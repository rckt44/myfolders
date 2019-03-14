* Program 7.2.5.sas
* Demonstrating the %UPCASE function;

%macro printit(dsn=);
  * use a KEEP for CLINICS;
  %if %upcase(&dsn)=CLINICS %then 
        %let keep=(keep=lname fname ssn);
  %else %let keep=;
  proc print data=&dsn &keep;
    title "Listing of %upcase(&dsn)";
    run;
%mend printit;
proc datasets nolist;
   copy in=macro3 out=work;
      select clinics;
   quit;
options mprint;
%printit(dsn=cLinICs)


