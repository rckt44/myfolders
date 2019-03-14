* Program 11.2.7a.sas
* Breakup a data set into component parts;
* This version assumes that the classification variable is character
* and that the value of the class variable forms a valid data set name;

%macro breakup(dsn=,classvar=); 
%local classcnt i;
proc sql noprint;
   select distinct &classvar
      into :cval1-
         from &dsn;
   %let classcnt=&sqlobs;
   quit;

data 
   %do i=1 %to &classcnt;
      class_&&cval&i
   %end;
   ;
   set &dsn;
   %do i=1 %to &classcnt;
      %if &i>1 %then else;
      if &classvar = "&&cval&i" then output class_&&cval&i;
   %end;
   run;

%mend breakup;
%breakup(dsn=macro3.clinics, classvar=sex)
