* Program 2.5.sas;
* Resolving a macro variable;
%let dsn = IAX;
title "Looking at &dsn";
proc contents data= &dsn;
   run;

proc print data= &dsn;
   run;


