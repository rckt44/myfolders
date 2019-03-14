* Program 12.1.2a.sas
* Append data sets using SASHELP.VTABLE;

%macro appnddsn(lib=DECNTRL);
%local i;
* Determine the data sets, make a macro var for each;
* use data set of the form &lib..INxxxxxx ;
data _null_;
  set sashelp.vtable(keep=libname memname) end=eof;  
  where libname="%upcase(&lib)" & memname=:'IN'; 
  call symputx(catt('dsn',_n_),memname,'l'); 
  if eof then call symputx('dsncnt',_n_,'l'); 
  run;

proc datasets library=work nolist;
  delete alldsn;

  * Append the data sets;
  %do i = 1 %to &dsncnt;
     append base=alldsn data=&lib..&&dsn&i; 
  %end;
  quit;
%mend appnddsn;
%appnddsn(lib=WORK)
