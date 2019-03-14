* Program 14.2.3a.sas
* Storing a series of macro variable lists in parallel.;

%macro PrtLists;
%local i;
%* Create lists;
proc sql noprint;
   select dsn, keyvar
      into :dsn1-,
           :keyvar1-
         from macro3.dbdir;
   %let dsncnt=&sqlobs;
   quit;
%do i = 1 %to &dsncnt;
   title1 "Showing Data Table &&dsn&i";
   proc print data=macro3.&&dsn&i;
   by &&keyvar&i;
   run;
%end;

%mend Prtlists;
%prtlists
