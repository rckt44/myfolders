* Carpenter_17835TW_Program 2.5.1.sas;
* Using a macro variable as a text suffix;
%let dsn = IAX;
title "Looking at protocol&dsn";
proc contents data= protocol&dsn;
   run;

proc print data= protocol&dsn;
   run;


