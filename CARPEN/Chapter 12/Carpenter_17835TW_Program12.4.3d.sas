* Program 12.4.3d.sas
* Building and using a list of individual words;

%* COUNTW is Program 11.4.4b.sas;
%macro countw(list,dlm);
   %* Count the number of words in &LIST;
   %if %length(&dlm)=0 %then %sysfunc(countw(&list));
   %else %sysfunc(countw(&list,&dlm));
%mend countw;

%macro makevars(list=);
%local wcnt;
%do wcnt = 1 %to %countw(&list);
   %let keyvar&wcnt = %qscan(&list,&wcnt,%str( ));
%end;
%mend makevars;

%macro countclass(dsn=, keyfld=);
%local i;
%* Build a local list of individual key variables;
%do i = 1 %to %countw(&keyfld);
   %local keyvar&i;
%end;

%* The macro variables created by %makevars will be written 
%* to the local table for %COUNTCLASS;
%makevars(list=&keyfld)

proc sort data=&dsn
          out=bytemp;
   by &keyfld;
   run;

data counts(keep=&keyfld classcnt);
   set bytemp;
   by &keyfld;
   if first.%unquote(%nrstr(&keyvar)%countw(&keyfld)) then classcnt=0;
   classcnt+1;
   if last.%unquote(%nrstr(&keyvar)%countw(&keyfld)) then output counts;
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
