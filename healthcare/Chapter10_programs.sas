** >>>   BE SURE TO ALLOCATE THE LIBREF 'BOOK' TO YOUR DATA SOURCE   <<< **;

** Chapter 10 programs ;

/*  Program 10.1 */

data facility;                                                         
    length Category1 Category2 $30;
    set book.facilityheader;

    BillType_1 = substr(BillType,1,1);
    BillType_2 = substr(BillType,2,1);

        if BillType_1 = '1' then Category1 = 'Hospital';
   else if BillType_1 = '2' then Category1 = 'SNF';
                            else Category1 = 'Other Facility';
             
  if Category1 = 'Hospital' 
    then do;
              if BillType_2 in ('1','2') then Category2 = 'Inpatient';
         else if BillType_2 = '3'        then Category2 = 'Outpatient';
                                         else Category2 = 'Hospital - Other';
        end; 
    else Category2 = Category1;
run;

proc sort data=facility;
    by claimid;
run;

* Identify ER;

proc sort data=book.facilitydetail 
           out=ERClaims(keep=claimid) nodupkey ;                       
    by claimid;
    where substr(RevCode,1,3) = '045';
run;

data facility2;
     merge facility(in=in1) ERClaims(in=in2);                          
     by claimid;
     if in1 or in2;
     if in2 then do;                                                   
                if Category2 = 'Inpatient'  then Category2 = 'ED Inpatient'; 
           else if Category2 = 'Outpatient' then Category2 = 'ED Outpatient';
     end;
run;

/*  Program 10.2 */

* Professional Claims;                                                 
data Professional;
    set book.Professionaldetail;
    length Category1 Category2 $30;
    select;
           when (    SrvcProvTaxonomy =: '20'
                 and substr(SrvcProvTaxonomy,3,2) in('7Q', '7V', '8D', '80'))
           Category1 = 'Primary Care';
           when (    SrvcProvTaxonomy =: '20' 
                 and Category1 ne 'Primary Care' ) 
           Category1 = 'Other Physician';
           when (SrvcProvTaxonomy in:('29', '33', '34') )
           Category1 = 'Ancillary';
           otherwise Category1 = 'Other Professional';
       end; 
    select;
           when (POS = '21')          Category2 = 'Inpatient';
           when (POS = '22')          Category2 = 'Outpatient';
           when (POS in('11','12'))   Category2 = 'Office/Home';
           otherwise                  Category2 = 'Other Setting';
       end; 
run;

proc sql;                                                              
    create table professional2 as
    select a.*
          ,b.memberid
      from professional                a
          ,book.professionalheader     b
     where a.claimid=b.claimid;
quit;

proc sort data=professional2;                                          
    by memberid;
run;

proc sort data=facility2;                                              
    by memberid;
run;

data AllClaims(keep=MemberID ClaimID Category1 
                    Category2 AmtPaid Month   );                       
    set facility2 professional2(rename=(LineAmtPaid=AmtPaid));
    by memberid;
    Month = put(coalesce(BeginDOS,AdmitDt),yymmn6.);                   
run;

/*  Program 10.3 */

* Invoke Member Months Macro that is compiled in Program 9.3 ;
%MM(beg=01JAN2011,end=31DEC2011,inputds=BOOK.Members);                 

proc sql;                                             
    create table mm2 as                                                
    select put(date,yymmn6.) as Month
          ,count(*) as members
      from mm
     group by Month;

    create table allclaims2 as                                         
    select Month, Category1, Category2
          ,sum(AmtPaid) as AmtPaid
      from AllClaims
     group by Month, Category1, Category2;

    create table metrics as                                            
    select a.Month, a.Category1, a.Category2
          ,(a.AmtPaid/b.members) as PaidPMPM
      from allclaims2 a, mm2 b
     where a.month=b.month;
quit;

/*  Program 10.4 */

proc tabulate data=Metrics;
    class Category1 Category2;                             
    var PaidPMPM;                                         
    table category1 category2 category1*category2, PaidPMPM;
run;

/*  Program 10.5 */

proc tabulate data=Metrics;
    class Category1 Category2;
    var PaidPMPM;
    table category1 all='Category1 Total' 
          category2 all='Category2 Total' 
          category1*category2  ,  PaidPMPM*MEAN=''*format=comma12.0 
                                  PaidPMPM*pctsum='Percent'*format=Comma12.2 
         /row=float;
run;




