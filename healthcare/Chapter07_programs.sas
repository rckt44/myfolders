** >>>   BE SURE TO ALLOCATE THE LIBREF 'BOOK' TO YOUR DATA SOURCE   <<< **;

** Chapter 7 programs ;

/* 7.2 */

* Compile complete study period;

proc sort data=book.Pharmacy 
          out=StudyPeriod(keep=MemberID NDC Label FillDate); 
    by MemberID NDC Label FillDate;                          
run;

/*checking total obs  */
/* proc sql; */
/* select count(*) as tot_obs from book.pharmacy; */
/* quit; */

proc sort data=StudyPeriod nodupkey;                         
    by MemberID NDC Label;
run;

data StudyPeriod2(drop=FillDate);
    set StudyPeriod;
    Interval="01DEC2011"d - FillDate;                        
    do i=1 to Interval + 1;                                  
      Date=intnx("day",FillDate,i-1);                        
      format Date yymmdd10.;                                 
      output;                                                
    end;                                                       
run;

/* 7.3 */

data pharmacy(keep=MemberID NDC Label Date RxAdherent);
    set book.pharmacy;
    do i=1 to Qty;                                           
      Date=intnx("day",FillDate,i-1);                         
      RxAdherent = 1;
      output;
      format Date yymmdd10.;
    end;
run;

/* 7.4 */

* Data sets need to be sorted prior to being merged;
proc sort data=Pharmacy;                          
    by MemberID NDC Label Date;
run;

proc sort data=StudyPeriod2;                      
    by MemberID NDC Label Date;
run;

data RxAdherence(drop=Interval i);
    merge Pharmacy StudyPeriod2;                  
    by MemberID NDC Label Date;                   
    count=1;                                      
    if RxAdherent=. then RxAdherent=0;            
run;

proc sql;                                         
    create table Summary as
    select MemberID, NDC, Label, 
          (sum(RxAdherent)/sum(Count)) as PDC format comma10.3
      from RxAdherence
     group by MemberID, NDC, Label;
quit;

/*  CHECK FOR AND CREATE IF NECESSARY THE APPROPRIATE FOLDER [not in book]  */

options noxwait;

data _null_;
    if not fileexist("C:\HealthCare Book")
      then %sysexec(mkdir "C:\HealthCare Book");;
run;

/* 7.6 */

* Example of Sub-Query;

proc sql;                                                        
    create table GraphPDC as
    select MemberID, NDC, Date, RxAdherent
      from RxAdherence
     where MemberID in (select distinct MemberID 
                          from summary 
                         where PDC<.6     ) 
     order by MemberID, NDC, Date;
quit;

ods pdf file="C:\HealthCare Book\PDC Graphs for Members.pdf";    

symbol1 interpol=join height=10pt value=none 
        line=1 width=2 cv = _style_;
axis1 style=1 width=1 minor=none;
axis2 style=1 width=1 minor=none;
title;
footnote;

/* Please note the following change from the book's code - the WHERE data set option is used
               to minimize the volume and execution time.                         

   Also, a note about the SAS log from the SAS Knowledge Base:
                The generation of the WARNING message is data-dependent.  
                The new method for determining the date axis range fails when the 
                  values in the SAS data set are not evenly spaced with a discernable pattern.  
                The WARNING message is not generated when an axis range is specified using the 
                  ORDER= option on an AXIS statement.
*/

proc gplot data = GraphPDC(where=(MemberID in( 'M0000106320012800'
                                              ,'M0000128390014000')))
           nocache;
    plot RxAdherent * Date/vaxis=axis1 haxis=axis2 frame;
    by MemberID NDC;
run; 
quit;

ods pdf close;


