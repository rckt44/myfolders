* Program 12.1.2f.sas
* Building a list of files with DATA step functions;

%macro appnddsn(lib=DECNTRL);
%local filrf rc did memcount i dsn;
* Determine the data set names of the form &lib..INxxxxxx ;

%let filrf=mydata;
%let rc=%sysfunc(filename(filrf, %sysfunc(pathname(&lib))));
%let did=%sysfunc(dopen(&filrf));

%let memcount=%sysfunc(dnum(&did));
%if &memcount > 0 %then %do;

   proc datasets library=work nolist;
      delete alldsn;

      %* Append the data sets;
      %do i = 1 %to &memcount;
         %let dsn=%sysfunc(dread(&did, &i));
         %if %upcase(%substr(&dsn,1,2))=IN and %scan(&dsn,2,.)=sas7bdat %then %do;
            append base=alldsn data=&lib..%scan(&dsn,1,.); 
         %end;
      %end;
      quit;
 
%end;
%let rc=%sysfunc(dclose(&did));
%let rc=%sysfunc(filename(filrf));

%mend appnddsn;
%appnddsn(lib=WORK)
