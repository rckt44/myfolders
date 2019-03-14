* Program 2.3a    An ungeneralized program;
title1 'Data Set clinics';
proc contents data=clinics;
   run;

proc print data=clinics (obs=10);
   run;
