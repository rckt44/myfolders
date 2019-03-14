* Program 7.5.2a.sas
* Testing to see if a data set exists
* using the EXIST function;

%macro exist(dsn);
%global exist;
%* Check if &DSN has been created;
%if %sysfunc(exist(&dsn)) %then %let exist=YES;
%else %let exist=NO;
%mend exist;  

%exist(macro3.clinics)
%put &exist;
