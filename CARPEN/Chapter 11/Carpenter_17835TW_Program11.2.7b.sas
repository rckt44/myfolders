* Program 11.2.7a.sas
* Breakup a data set into component parts;
* This version assumes that the classification variable is character
* and that the value of the class variable forms a valid data set name
* after compressing out the non-acceptable characters;

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
      class_%sysfunc(compress(&&cval&i,,kn))
   %end;
   ;
   set &dsn;
   %do i=1 %to &classcnt;
      %if &i>1 %then else;
      if &classvar = "&&cval&i" then output class_%sysfunc(compress(&&cval&i,,kn));
   %end;
   run;

%mend breakup;
%breakup(dsn=sashelp.cars, classvar=make)
