* Program 12.1.2c.sas
* Using PROC CONTENTS to build a list of data sets;

%macro appnddsn(lib=DECNTRL);
%local i;
* Determine the data sets, make a macro var for each;
* use data set of the form &lib..INxxxxxx ;

* ALLCONT will have one observation for each variable in 
* each data set in the &LIB library;
proc contents data=&lib.._all_
              out=allcont(keep=memname  
                          where=(memname=:'IN'))
              noprint;
run;

* Build the list of unique data sets;
proc sql noprint;
   select distinct memname
      into :dsn1-
         from allcont;
   %let dsncnt=&sqlobs;
   quit;

proc datasets library=work nolist;
  delete alldsn;

  * Append the data sets;
  %do i = 1 %to &dsncnt;
     append base=alldsn data=&lib..&&dsn&i; 
  %end;
  quit;
%mend appnddsn;
%appnddsn(lib=WORK)
