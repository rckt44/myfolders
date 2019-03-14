* Program 10.3.2c.sas
* Using stored compiled macro libraries;

%macro aerpt(dsn, stdate, aelist) / store;
   %put testing AERPT;
%mend aerpt;
 
