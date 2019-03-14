** >>>   BE SURE TO ALLOCATE THE LIBREF 'BOOK' TO YOUR DATA SOURCE   <<< **;

** Chapter 11 programs ;

/* Program 11.1  */

proc sort data=book.Members out=Members nodupkey;                  
    by MemberID BeginEnroll EndEnroll;
run;

data Members_Clean(drop=prior_: temp_: orig_:);
    retain MemberID temp_beg temp_end;                             
    format Prior_End Orig_BeginEnroll Orig_EndEnroll 
           temp_beg temp_end BeginEnroll EndEnroll yymmdd10.;

    set members(rename=(BeginEnroll=Orig_BeginEnroll
                        EndEnroll  =Orig_EndEnroll  ));            
    by memberid Orig_BeginEnroll Orig_EndEnroll;

    if Orig_BeginEnroll > Orig_EndEnroll then delete;              
    Prior_End = lag(Orig_EndEnroll);                               

         if first.memberid 
           then do;                                                
                   temp_beg  = Orig_BeginEnroll;   
                   temp_end  = Orig_EndEnroll;       
                   Prior_End = .;                      
               end;
    else if 0 <= (Orig_BeginEnroll - Prior_End) <= 1 
           then do;                                                
                   temp_end = Orig_EndEnroll;
               end;
    else if (Orig_BeginEnroll - temp_end) >  1 
           then do;                                                
                   BeginEnroll = temp_beg;
                   EndEnroll   = temp_end;
                   output;                                         
                   temp_beg = Orig_BeginEnroll;                    
                   temp_end = Orig_EndEnroll;                   
               end;
    else if temp_beg <= Orig_BeginEnroll <= temp_end 
           then do;                                                 
                   if Orig_EndEnroll > temp_end 
                     then temp_end = Orig_EndEnroll;               
               end;
   if last.memberid then do;                                       
                            BeginEnroll = temp_beg;    
                            if Orig_EndEnroll > temp_end 
                              then EndEnroll = Orig_EndEnroll; 
                              else EndEnroll = temp_end;   
                            output;                       
                        end;
run;

/* Program 11.2  */

%macro CE( sasds=       /* SAS dataset to start with     */ 
          ,msryr=       /* measure year of interest      */
          ,prioryrs=    /* # of prior years of interest  */
          ,anchordt=    /* anchor date for the measure   */
         ); 

%let beginyr = %eval(&msryr - &prioryrs);                     

%do yr = &beginyr %to &msryr;                                 

data calyr&yr;                                       
    set &sasds(where=(    BeginEnroll <= "31DEC&yr"d 
                      and EndEnroll   >= "01JAN&yr"d   ));    
    Start = max(BeginEnroll,"01JAN&yr"d);                     
    End   = min(EndEnroll  ,"31DEC&yr"d);                     
    format Start End yymmdd10.;
run;
   
proc sort data=calyr&yr;
    by MemberID start end;
run;

data calyr&yr;   
    set calyr&yr;
    by MemberID Start End;
    LEnd = lag(end);                                          
    format LEnd yymmdd10.;

* Initiate gap counters;
    if first.MemberID 
      then do;                                                
              LEnd       = .; 
              GapsNbr&yr = 0;
              GapDays&yr = 0;
          end;

* Gap at the beginning;                                       
    if     first.MemberID 
       and (start - "01JAN&yr"d) > 0 
      then do;
              GapDays&yr + (start - "01JAN&yr"d); 
              GapsNbr&yr + 1; 
          end; 
 
* Gap(s) in the middle;                                       
    if not first.MemberID 
      then do;
              GapDays&yr +  (Start - LEnd - 1); 
              GapsNbr&yr + ((Start - LEnd - 1) > 1); 
          end;

* Gap at the end;                                             
    If last.MemberID and ("31DEC&yr"d-end) >= 1 
     then do;
             GapDays&yr + ("31DEC&yr"d-end); 
             GapsNbr&yr + 1; 
         end; 

* Output the MemberID record;                                 
    if last.MemberID 
      then do;                                                
              if    GapsNbr&yr > 1 
                 or (GapsNbr&yr = 1 and GapDays&yr > 45)
                then CE&yr = 'FAIL';
                else CE&yr = 'PASS';
              output;
          end; 
run;

%end;

data ce_final(drop=start end );                               
%if &beginyr < &msryr %then                                              
    merge; 
                      %else
    set;
%do yr = &beginyr %to &msryr;
          calyr&yr(drop=lend in=x&yr) 
%end;  ;
    by MemberID ;
%do yr = &beginyr %to &msryr;
    if not x&yr then ce&yr= 'FAIL';      
 %if %sysfunc(year(&anchordt)) = &yr %then 
    anchored = (start <= &anchordt <= end);
                                     %else 
    anchored = 0;;                                            
 %end; 
   if    anchored = 0 
 %do yr = &beginyr %to &msryr;
      or CE&yr = 'FAIL'
 %end; 
    then CE = 'FAIL';
    else CE = 'PASS';
run;
%mend CE;

/* Program 11.3  */

%let Msryr=2011;

*** --------------------------------------------------------- ***
*** Part 1 – include and execute the CE macro                 ***
***        - create the initial denominator                   ***
*** --------------------------------------------------------- **;

options mprint;
/* the following is commented out for ease of demonstration.  Should you have saved the
   compilable macro in a .sas file it could be referenced and used instead of having it
   instream as above
*/
*  %include "C:\HealthCare Book\Macro programs\Program 11.2.sas"/source2;
%CE(sasds=Members_Clean,msryr=2011,prioryrs=1,anchordt="31DEC2011"d);

proc sql;                                                                                
    create table Col_Denominator as
    select distinct memberid
          ,floor( (intck('month',dob,"31DEC&MsrYr"d)
                 -(day("31DEC&MsrYr"d)<day(dob)))/12) as age         
      from book.members
     where     calculated age between 51 and 75 
           and memberid in (select distinct memberid 
                              from CE_final 
                             where CE="PASS");  
quit;

*** --------------------------------------------------------- ***
*** Part 2 – create column-wise versions of the claims data   ***
*** --------------------------------------------------------- **;

data fac_header_codes (keep=ClaimID MemberID DischgDt
                            CodeValue CodeType CodeRole);
    set book.FacilityHeader;                             
    array dx $ pDx Dx_: ;                                
    array px $ pPx Px_: ;
    length CodeValue $5 CodeType $7 CodeRole $1;
    do i = 1 to dim(dx);                                  
                        if dx(i)  = " " then leave;                          
                        CodeValue = dx{i};                                 
                        CodeType  = "ICD9CM";                              
                        if i = 1 then CodeRole = "1";                      
                                 else CodeRole = "2";                       
                        output work.fac_header_codes;                       
    end;
    do j = 1 to dim(px);                                 
                        if px(j)  = " " then leave;
                        CodeValue = px{j};
                        CodeType  = "ICD9PCS";
                        if j = 1 then CodeRole = "1";
                                 else CodeRole = "2";
                        output work.fac_header_codes;                 
    end;
run;

proc sort data=fac_header_codes;
    by MemberID ClaimID;
run;

data pro_detail_codes(keep=ClaimID CodeValue CodeType BeginDOS);
    set book.ProfessionalDetail;                          
    array dx $ PointerDx1 - PointerDx4 ;                  
    length CodeValue $5 CodeType $7 ;
    do i = 1 to dim(dx);                                  
                        if dx(i)  = " " then leave;                          
                        CodeValue = dx{i};                                  
                        CodeType  = "ICD9CM";                               
                        output work.pro_detail_codes;                       
    end;
    CodeValue = Px;                                     
    if anyalpha(Px) = 1 then CodeType  = "HCPCS";  
    if anyalpha(Px) = 0 then CodeType  = "CPT";       
    output work.pro_detail_codes;                       
run;

proc sort data=pro_detail_codes nodupkey;          
    by ClaimID CodeValue CodeType BeginDOS;
run;

*** --------------------------------------------------------- ***
*** Part 3 – create a list of the excludable members          ***
***        - create the final denominator                     ***
*** --------------------------------------------------------- **;

proc sql;
    create table Excludable_Mbrs as
    select distinct 
           a.MemberID
          ,a.CodeType     length=7
          ,a.CodeValue
          ,a.CodeRole
          ,"Facility"              as Source
          ,b.ValueSet
      from fac_header_codes   a
          ,BOOK.ColDriver     b
     where a.CodeValue = compress(b.CodeValue,'.') 
       and upcase(b.CodeType)  in("ICD9CM","ICD9PCS") 
       and upcase(b.ValueSet)  in("COLORECTAL CANCER","TOTAL COLECTOMY") 
       and a.DischgDt <= "31DEC&msryr."D                                                 
     UNION
    select distinct
           a.MemberID
          ,b.CodeType     length=7
          ,b.CodeValue
          ," "                    as CodeRole
          ,"Professional"         as Source
          ,c.ValueSet
      from book.Professionalheader  a 
      join pro_detail_codes         b
        on a.ClaimID = b.ClaimID
      join BOOK.ColDriver           c
        on b.CodeValue = compress(c.CodeValue,'.') 
       and upcase(b.CodeType)  in("ICD9CM","CPT","HCPCS") 
       and upcase(c.ValueSet)  in("COLORECTAL CANCER","TOTAL COLECTOMY") 
       and b.BeginDOS <= "31DEC&msryr"D   
     UNION
    select distinct
           a.MemberID
          ,c.CodeType     length=7
          ,b.Px                   as CodeValue
          ," "                    as CodeRole
          ,"Facility"             as Source
          ,c.ValueSet
      from book.Facilityheader  a
      join book.Facilitydetail  b
        on a.ClaimID = b.ClaimID
      join BOOK.ColDriver       c
        on b.Px = c.CodeValue 
     where upcase(c.CodeType)  in("CPT","HCPCS") 
       and upcase(c.ValueSet)  in("COLORECTAL CANCER","TOTAL COLECTOMY") 
       and a.DischgDt <= "31DEC&msryr"D
    ;

    create table Col_Denominator_Final as
    select *
      from Col_Denominator 
     where memberid not in(select distinct memberid 
                            from Excludable_Mbrs)   ;
quit;

/* Program 11.4  */

proc sql;
    create table Col_Numerator_Final as
    select hdr.MemberID
          ,dtl.BeginDos
          ,dtl.Px              as CodeValue
          ,rul.CodeType
          ,"Professional"      as Source
          ,rul.ValueSet
      from book.professionalheader   hdr                    
      join book.professionaldetail   dtl
        on hdr.ClaimID  = dtl.ClaimID 
       and hdr.MemberID in                                  
                          (select distinct MemberID 
                             from Col_Denominator_Final)
      join BOOK.ColDriver            rul                    
        on dtl.Px  = rul.CodeValue
     where (    rul.CodeType          = "CPT" 
            and upcase(rul.ValueSet)  = "FOBT"
            and year(dtl.BeginDOS)    = &MsrYr   )          
        or (    rul.CodeType= "CPT" 
            and upcase(rul.ValueSet) = "FLEXIBLE SIGMOIDOSCOPY" 
            and year(dtl.BeginDOS)   between (&MsrYr - 4) 
                                         and &MsrYr
           )                                                
        or (    rul.CodeType= "CPT" 
            and upcase(rul.ValueSet) = "COLONOSCOPY" 
            and year(dtl.BeginDOS)   between (&MsrYr - 9) 
                                         and  &MsrYr
           )                                                
UNION
    select hdr.MemberID                                     
          ,dtl.BeginDos
          ,dtl.Px              as CodeValue
          ,rul.CodeType
          ,"Facility"          as Source
          ,rul.ValueSet
      from book.facilityheader     hdr
      join book.facilitydetail     dtl
        on hdr.ClaimID  = dtl.ClaimID 
       and hdr.MemberID in 
                           (select distinct MemberID 
                              from Col_Denominator_Final)
      join BOOK.ColDriver          rul
        on dtl.Px  = rul.CodeValue
     where (    rul.CodeType in("CPT", "HCPCS") 
            and upcase(rul.ValueSet) = "FOBT" 
            and year(dtl.BeginDOS)   = &MsrYr     )
        or (    rul.CodeType in("CPT", "HCPCS") 
            and upcase(rul.ValueSet) = "FLEXIBLE SIGMOIDOSCOPY"
            and year(dtl.BeginDOS) between (&MsrYr - 4) 
                                       and  &MsrYr     )
        or (    rul.CodeType in("CPT", "HCPCS") 
            and upcase(rul.ValueSet) = "COLONOSCOPY" 
            and year(dtl.BeginDOS)   between (&MsrYr - 9) 
                                         and  &MsrYr     )
;
quit;

/* Program 11.5  */

proc sql;
    create table dummy(dummy character(1));                  
    insert into  dummy values(' ');

    title 'Rate Calculation for Colorectal Cancer Screening';
    select (select count(distinct MemberID) 
              from COL_Numerator_Final     )      as numer   
          ,(select count(distinct MemberID) 
              from COL_Denominator_Final)         as denom   
          ,calculated numer / calculated denom 
                              format=percent7.3   as rate    
     from dummy;                                             
quit;
