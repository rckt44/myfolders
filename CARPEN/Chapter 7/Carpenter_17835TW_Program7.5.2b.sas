* Program 7.5.2b.sas
* Testing to see if a data set exists
* using the EXIST function;

%macro exist(dsn);
   %* Check if &DSN has been created;
   %if %sysfunc(exist(&dsn)) %then YES;
   %else NO;
%mend exist;
%put |%exist(macro3.clinics)|;
