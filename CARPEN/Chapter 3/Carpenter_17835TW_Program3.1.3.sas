* Program3.1.3.sas
* Create a macro description;

%macro look /des='Explore a data set';
title1 "Data Set &dsn";
proc contents data=&dsn;
  run;

proc print data=&dsn (obs=10);
  run;
%mend look;
%let dsn = macro3.clinics;

%look
