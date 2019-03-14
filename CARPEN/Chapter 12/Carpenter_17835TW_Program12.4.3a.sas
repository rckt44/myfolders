* Program 12.4.3a.sas
* Using the last word in a list;

%macro countclass(dsn=, keyfld=);

proc sort data=&dsn
          out=bytemp;
   by &keyfld;
   run;

data counts(keep=&keyfld classcnt);
   set bytemp;
   by &keyfld;
   if first.%scan(&keyfld,-1,%str( )) then classcnt=0;
   classcnt+1;
   if last.%scan(&keyfld,1,%str( ),b) then output counts;
   run;

title1 "Counts within &dsn";
title2 "BYLIST: &keyfld";
proc print data=counts;
   id &keyfld;
   var classcnt;
   run;
%mend countclass;
options nomprint;
%countclass(dsn=macro3.clinics, keyfld=region)
%countclass(dsn=macro3.clinics, keyfld=region clinnum)
