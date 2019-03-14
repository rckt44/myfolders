* Carpenter_17835TW_Program 2.5.2b.sas;
* Using the dot to avoid macro variable name ambiguity;
%let dsn = IAX;
title "Looking at &dsn.protocol";
proc contents data= &dsn.protocol;
   run;

proc print data= &dsn.protocol;
   run;



