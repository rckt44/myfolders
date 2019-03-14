** >>>   BE SURE TO ALLOCATE THE LIBREF 'BOOK' TO YOUR DATA SOURCE   <<< **;

** Chapter 9 programs ;

/* Program 9.1  */

%macro SelectMembers(beg=,end=); 
data Member;
    set BOOK.Members;
    if BeginEnroll > "&end"d or EndEnroll < "&beg"d 
      then delete;
run;
%mend SelectMembers;

/* Program 9.2  */

options symbolgen;

/* the following is commented out for ease of demonstration.  Should you have saved the
   compilable macro in a .sas file it could be referenced and used instead of having it
   instream as above
*/
*%include "C:\HealthCare Book\Macro programs\Program 9.1.sas"/source2;
%SelectMembers(beg=01JAN2011,end=31DEC2011)

/* Program 9.3  */

%macro MM(beg=,end=,inputds=);

data member;
    set &inputds;                                                  
    if BeginEnroll > "&end"d or EndEnroll < "&beg"d then delete;   
    NewBeg = max("&beg"d,BeginEnroll);                             
    NewEnd = min("&end"d,EndEnroll);                               
    Months = intck('MONTHS',NewBeg,NewEnd) + 1;                    
    format NewBeg NewEnd yymmdd10.;
run;

proc sort data=member;
    by MemberID;
run;

data MMTemp;
    set member;
    keep MemberID date sex DOB;
    format date yymmdd10.;
    do i=1 to months;                                              
      date=intnx('MONTHS',NewBeg,i-1,'B');                         
      output;
    end;
run;

proc sql;                                                          
    create table MM as
    select distinct MemberID, date, sex, DOB
      from MMTemp;
quit;

/* Optional code for deleting intermediate datasets                

proc datasets library=WORK;
    delete MMTemp Member;
run; 

   End of optional code */

%mend MM;

* Invoke macro;
%MM(beg=01JAN2011,end=31DEC2011,inputds=BOOK.Members)

/* Program 9.4  */

%macro MM2(yr=,inputds=);

%let beg = 01JAN&yr;                                                  
%let end = 31DEC&yr;

proc sort data=&inputds(where=(not(   BeginEnroll > "&end"d           
                                   or EndEnroll < "&beg"d  ))
                        keep = MemberID Sex DOB BeginEnroll EndEnroll  
                       )
           out=temp_mm;         
    by MemberID BeginEnroll;
run;

data mmtable(drop=j k BeginEnroll EndEnroll);
    retain MemberID Sex DOB jan&yr feb&yr mar&yr apr&yr may&yr jun&yr  
                            jul&yr aug&yr sep&yr oct&yr nov&yr dec&yr;       
    array mbrmon (12) jan&yr feb&yr mar&yr apr&yr may&yr jun&yr        
                      jul&yr aug&yr sep&yr oct&yr nov&yr dec&yr;
    set temp_mm;
    by MemberID;

    if first.MemberID                                                  
      then do j = 1 to dim(mbrmon); 
              mbrmon(j) = 0;        *** initialize the array to 0 ***;
           end;  

    do k =    month(max("&beg"d,BeginEnroll)) 
           to month(min("&end"d,EndEnroll  )) ;                        
       mbrmon(k) = 1;
    end;

    if last.MemberID then do;                                          
                              totmm = sum(of jan&yr. -- dec&yr.); 
                              output mmtable; 
                          end;
run;

%mend MM2;

%MM2(yr=2011,inputds=BOOK.Members);
