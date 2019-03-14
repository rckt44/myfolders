* Program 12.4.3b.sas
* Using the last word in a list as returned by %COUNTW;

%* COUNTW is Program 11.4.4b.sas;
%macro countw(list,dlm);
   %* Count the number of words in &LIST;
   %if %length(&dlm)=0 %then %sysfunc(countw(&list));
   %else %sysfunc(countw(&list,&dlm));
%mend countw;

%macro countclass(dsn=, keyfld=);
proc sort data=&dsn
          out=bytemp;
   by &keyfld;
   run;

data counts(keep=&keyfld classcnt);
   set bytemp;
   by &keyfld;
   if first.%scan(&keyfld,%countw(&keyfld),%str( )) then classcnt=0;
   classcnt+1;
   if last.%scan(&keyfld,%countw(&keyfld),%str( )) then output counts;
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
