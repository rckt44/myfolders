* Program 12.1.2b.sas
* Append data sets using DICTIONARY.TABLES;

%macro appnddsn(lib=DECNTRL);
%local i;
* Determine the data sets, make a macro var for each;
* use data set of the form &lib..INxxxxxx ;
proc sql noprint;
   select memname
      into :dsn1-
         from dictionary.tables
            where libname="%upcase(&lib)" & 
                  substr(memname,1,2)='IN';
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
