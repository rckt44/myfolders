* Program3.1.1.sas
* Create a simple macro;

%macro look;
title1 "Data Set &dsn";
proc contents data=&dsn;
  run;

proc print data=&dsn (obs=10);
  run;
%mend look;
%let dsn = macro3.clinics;

%look
