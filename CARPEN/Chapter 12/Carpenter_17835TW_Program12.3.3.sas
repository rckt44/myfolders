* Program 12.3.3.sas
* Establish a libref with a specified engine;

%macro mklib(lname=, engine=V9, lloc=);
%* Establish a libref
%*   lname    new libref name
%*   engine   engine type (optional)
%*   lloc     path or location
%*              may be an existing libref
%*;

%local rc;
%* Clear the libref if it exists;
%if %sysfunc(libref(&lname))=0  %then
      %let rc = %sysfunc(libname(&lname)); 

%* Determine if &lloc is already a libref;
%if %length(&lloc) le 8 and %sysfunc(libref(&lloc))=0 %then  
      %let lloc = %sysfunc(pathname(&lloc));  
%let rc = %sysfunc(libname(&lname,&lloc,&engine));  
   %put &rc %sysfunc(sysmsg());
%if &rc ne 0 %then %do;
   %put &rc %sysfunc(sysmsg());
   %let rc = %sysfunc(libname(&lname));  
%end;
%mend mklib;
options nomprint nosymbolgen nomlogic;
%mklib(lname=mymac6, engine=v6, lloc=macro3)
%mklib(lname=mymac9, engine=v9, lloc=c:\temp)
%mklib(lname=myoops, engine=v9, lloc=c:\temp\doesnotexist)


