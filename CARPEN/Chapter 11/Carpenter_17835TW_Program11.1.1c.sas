* Program 11.1.1c.sas
* A vertical list of one element;

%let dsn=macro3.clinics;

%macro printit(dset);
   title1 "First 10 obs of &&&dset";
   proc print data=&&&dset(obs=10);
   run;
%mend printit;
%printit(dsn)



 
