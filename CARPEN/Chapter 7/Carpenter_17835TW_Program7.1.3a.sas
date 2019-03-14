* Program 7.1.3a.sas
* Quoting to mask a DATA step;
%macro exist(dsn=);
%global exist;
%if &dsn ne %then %str(
   data _null_; 
   if 0 then set &dsn;
   stop;
   run;
   );
%if &syserr=0 %then %let exist=yes;
%else %do;
   %let exist=no;
   %put WARNING: PREVIOUS ERROR USED TO CHECK FOR PRESENCE ;
   %put WARNING- OF DATASET &DSN & IS NOT A PROBLEM;
%end;
%mend exist;
%exist(dsn=sashelp.clxxxx)
