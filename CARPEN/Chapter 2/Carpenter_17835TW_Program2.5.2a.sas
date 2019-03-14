* Carpenter_17835TW_Program 2.5.2a.sas;
* Indeterminable macro tokens;
* This program will fail.;
%let dsn = IAX;
title "Looking at &dsnprotocol";
proc contents data= &dsnprotocol;
   run;

proc print data= &dsnprotocol;
   run;



