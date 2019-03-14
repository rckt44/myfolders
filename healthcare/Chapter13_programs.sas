** >>>   BE SURE TO ALLOCATE THE LIBREF 'BOOK' TO YOUR DATA SOURCE   <<< **;

** Chapter 13 programs ;

/*  Program 13.1 */

%macro ageasof(asofdt=, dob=);
  %*--------------------------------------------------------------------*
   * Computes the age in years (as a person does it,                    *
   *                              marking birthdays exactly.)           *
   *                                                                    *
   * Note: This macro was copied from SAS-L and is the work of          *
   *       William Kreuter (algorithm) and Ian Whitlock (macrotization) *
   *        It has been widely used since 1995.                         *
   *                                                                    *
   * Usage: age = %ageasof(asofdt=refdate,dob=brthdate)                 *
   *                                                                    *
   * Parameters named because reversed arguments do not give negative   *
   *            of correct age.                                         *
   *--------------------------------------------------------------------*
  ;
  floor( (  intck('month',&dob,&asofdt)
          - (day(&asofdt)<day(&dob))
         )/12
       );
%mend ageasof;

/**** USE EXAMPLE ****/

proc sort data=book.members
           out=members(keep=memberid dob) nodupkey;
    by memberid;
run;

data age;
    set members;
    age = %ageasof(asofdt='07JUL2014'd,dob=DOB);
run;

/*  Program 13.2 */

data sparsetest;
infile datalines firstobs=3;
input n100       n90       n80       n10      constant
     c100 $ 18  c90 $ 22  c80 $ 26  c10 $ 30         ;
datalines;
         1         2         3
123456789012345678901234567890
.   .   .   1   9    a       a
.   2   .   2   9            c
.   .   .   3   9        c
.   .   3   2   9            d
.   .   2   3   9        b   e
.   .   .   1   9            a
.   .   .   2   9            d
.   .   .   3   9            c
.   .   .   4   9            a
.   .   .   .   9            d
;
run;

OPTIONS MPRINT SYMBOLGEN NOQUOTELENMAX;

*** ----------------------------------------------------------------- ***
*** Goal - demonstrate a technique for determining the sparsity of    ***
***           dataset variables.                                      ***
*** A macro is constructed so as to be able to check any dataset at   ***
***   any level (percentage) of sparseness.  The macro also allows    ***
***   for dropping the variables, or not, as part of  the macro       ***
***   execution.  The macro variable containing the list of vars to   ***
***   be dropped can be used at a later time if dropping them now is  ***
***   not required.                                                   ***
*** ----------------------------------------------------------------- **;

%MACRO SPARSEVARS( dsin=             /* input dataset                  */
                  ,dsout=            /* output ds                      */
                  ,pct_sparse=100    /* threshold to address           */
                  ,alter=N           /* drop the sparse variables? Y/N
                                        &dsout is used as target       */
                  ,print=N           /* create a ds of the dropped
                                        sparse variables?          Y/N */
                 );

%if %symexist(sparsevars) %then %symdel sparsevars;

proc format;
     value nmiss
                 . = " "
             other = "1"
     ;
     value $cmiss
                " " = " "
              other = "1"
     ;
run;

ods select none;
ods output onewayfreqs = oneways;
ods output nlevels = nvalues ;

proc freq data = &dsin nlevels order= formatted ;
    format _character_ $cmiss. _numeric_ nmiss.;
    table _all_ / missing;
run;

%let opendsid=%sysfunc(open(nvalues));
%let num=%sysfunc(varnum(&opendsid,nmisslevels));
%let closedsid=%sysfunc(close(&opendsid));

%global sparsevars;

%if &num > 0 %then %do;
proc sql noprint ;
    select scan(table,2," ") as var
      into :sparsevars separated by " "
      from oneways
     where percent  >= &pct_sparse
       and frequency = cumfrequency
       and (select nmisslevels
              from nvalues
             where calculated var = tablevar) = 1
    ;

%if &dsout ne &dsin %then %do;
    create table &dsout as
    select *
      from &dsin;
                         %end;
%if (%upcase(&alter) = Y and &sparsevars ne ) %then %do;
 %let sparsevars = %sysfunc(translate(&sparsevars,","," "));
     alter table &dsout.
      drop &sparsevars;
                                                   %end;
quit;

%if (%upcase(&print) = Y and &sparsevars ne ) %then %do;
data droppedvars(drop=i varcnt string strlen);
    varcnt = count("&sparsevars",
%if %upcase(&alter) = Y %then    ",") + 1;
                        %else    " ") + 1;;
    length string $20000;
    string = "&sparsevars";
    strlen = length(string);
    do i = 1 to varcnt;
                       droppedvar = scan(string,i);
                       output;
    end;
run;
                                                   %end;
%if &sparsevars ne %then %put
NOTE: THE FOLLOWING VARIABLES MET THE &pct_sparse.% SPARSENESS CRITERIA:
      &sparsevars;
                   %else %put
NOTE: NO VARIABLES MET THE &pct_sparse.% SPARSENESS CRITERIA. ;
                   %end;
%else %put NOTE: There are no missing levels in &dsin
-- This is a good thing;

options quotelenmax;
ods select all;

%MEND SPARSEVARS;

%SPARSEVARS( dsin=sparsetest
            ,dsout=testout
            ,pct_sparse=100
            ,alter=Y
            ,print=Y
           );

%SPARSEVARS( dsin=sparsetest
            ,dsout=sparsetest
            ,pct_sparse=50
            ,alter=Y
            ,print=N
           );

/*  Program 13.3 */

%macro hdrarraycodes( libref       =              /* library reference */
                     ,hdrdsn       =              /* header table name */
                     ,dtldsn       =              /* detail table name */
                     ,patientidvar = MemberID     /* hdr member id var */
                     ,clmidvar     = ClaimID      /* claim id var      */
                     ,clmlinevar   = ClaimLine    /* claim line id var */
                     ,dtlvar2array =              /* var of interest
                                                        to array       */
                     ,maxnumoflines=              /* # of lines to use,
                                                     blank for all     */
                     ,hdrkeepvars  =              /* hdr vars to keep  */
                    );

%*** ---------------------------------------------------------------- ***
*** Goal - create column-wise structure from a row-wise structure     ***
***        specifically, put each field value from the detail file    ***
***          into an array of fields on an image of the header record ***
***        example - bring all Revenue Codes, or the first N,         ***
***                  from the Facility Detail Table (rowwise) to      ***
***                  a copy of the Facility Header Table (columnwise) ***
***        this macro                                                 ***
***            handles only one arrayed variable although it could    ***
***                    be expanded for more                           ***
***            assumes a claim line number sort order, a further      ***
***                    enhancement is to make this user choice        ***
*** ---------------------------------------------------------------- ***;

proc sql noprint;
    select max(maxlines)
      into :linecnt  separated by ","
      from (select &clmidvar ,count(*)   as maxlines
              from &libref..&dtldsn
              group by &clmidvar)
    ;
    create table claimdtl as
    select *
      from &libref..&dtldsn(keep=&clmidvar &clmlinevar &dtlvar2array)
     order by &clmidvar, &clmlinevar
    ;
    create table claimhdr as
    select *
      from &libref..&hdrdsn(keep= &patientidvar &clmidvar &hdrkeepvars)
     order by &clmidvar
    ;
quit;

%if &maxnumoflines ne
   %then %let linecnt = &maxnumoflines.;

%put NOTE: Need &linecnt new columns to store the arrayed information;

data &hdrdsn._colwise;
    retain &patientidvar. &clmidvar. &hdrkeepvars.;
    drop i &dtlvar2array.;
    array temp $ &dtlvar2array.1 - &dtlvar2array.&linecnt.;
    do i=1 to &linecnt.;
                        merge claimhdr claimdtl;
                        by &clmidvar.;
                        temp(i) = &dtlvar2array.;
                        if last.&clmidvar.
                          then do;
                                  output;
                                  leave;
                              end;
    end;
run;

%mend hdrarraycodes;

%hdrarraycodes( libref       = book
               ,hdrdsn       = Facilityheader
               ,dtldsn       = Facilitydetail
               ,patientidvar = MemberID
               ,clmidvar     = ClaimID
               ,clmlinevar   = ClaimLine
               ,dtlvar2array = RevCode
               ,maxnumoflines= 10
               ,hdrkeepvars  = BillType DRG
              );

/*  Program 13.4 */

*** ----------------------------------------------------------------- ***
***          Build test claim files from scratch (header and detail)  ***
***          this is a useful exercise as it not only provides data   ***
***          to play with, but we exercise some tools for randomly    ***
***          generating data                                          ***
***        - the random seed is a constant to get reproducible data   ***
*** ----------------------------------------------------------------- **;

data test_hdr(keep=MemberID ClaimID dx01 - dx12)
     test_dtl(keep=MemberID ClaimID ClaimLine dxpointer Px);
    length MemberID $3 ClaimID $9 ClaimLine 3 dxpointer $12;
    array dx (*) $ dx01 - dx12;
    do mbr = 1 to 3;                                            *loop #1;
      MemberID = cats('00',mbr);
      do clm = 1 to (int(8 * ranuni(2)) + 1);                   *loop #2;
        ClaimID = cats(MemberID,'ccc00',clm);
        do x = 1 to dim(Dx);
          Dx(x) = ' ' ;
        end;
        do k = 1 to (int(12 * ranuni(4)) + 1);
          dx(k) = put((int(99999 * ranuni(12)) + 1),5.);
        end;
        output test_hdr;
        do claimline = 1 to (int(10 * ranuni(8)) + 1);          *loop #3;
          dxpointer = ' ';
          do z = 1 to 4;
          substr(dxpointer,z) = byte(round(65+((k-1)*ranuni(0)),1));
          end;
          len=length(dxpointer);
          do x = 1 to len-1;
            if substr(dxpointer,x,1) ^= ' '
              then do y = x+1 to len;
                   if substr(dxpointer,x,1)=substr(dxpointer,y,1)
                        then substr(dxpointer,y,1)=' ';
                   end;
          end;
          dxpointer=compress(dxpointer,' ');
          Px =  put((int(99507 * ranuni(12)) + 100),z5.);
          output test_dtl;

            end;                                           *ends loop #3;
        end;                                               *ends loop #2;
    end;                                                   *ends loop #1;
run;

/*  Program 13.5 */

*** ----------------------------------------------------------------- ***
***          Put the correct Dxs from the header on to a copy of the  ***
***          detail table using the DxPointer string on each line     ***
*** ----------------------------------------------------------------- **;

data  detail(drop=dx01-dx12 dxpointer i);
    merge test_hdr
          test_dtl;
    by MemberID ClaimID;
    array dx   (*) $ dx01  - dx12 ;
    array dxpt (*) $ dxpt1 - dxpt4;
    do i = 1 to length(dxpointer);
        dxpt(i) = ' ';
        dxpt(i) = dx(rank(substr(dxpointer,i,1))-64);
    end;
run;

*** ----------------------------------------------------------------- ***
***          Put the correct Dxs from the header on to a copy of the  ***
***          detail table using the DxPointer string on each line     ***
*** ----------------------------------------------------------------- **;

data  detail(drop=dx01-dx12 dxpointer i);
    merge test_hdr
          test_dtl;
    by MemberID ClaimID;
    array dx   (*) $ dx01  - dx12 ;
    array dxpt (*) $ dxpt1 - dxpt4;
    do i = 1 to length(dxpointer);
        dxpt(i) = ' ';
        dxpt(i) = dx(rank(substr(dxpointer,i,1))-64);
    end;
run;
