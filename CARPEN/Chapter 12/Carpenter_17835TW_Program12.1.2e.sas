* Program 12.1.2e.sas
* Building a list of files with the FILENAME statement
* and the PIPE device type.;

%macro appnddsn(lib=DECNTRL);
%local i depath;
* Determine the data sets, make a macro var for each;
* use data set of the form &lib..INxxxxxx ;

* Create a list of all data sets in the &LIB library;
%let depath = %sysfunc(pathname(&lib));  
filename list pipe %unquote(%bquote(')dir "&depath\in*.sas7bdat" /o:n /b %bquote('));
* When using SAS9.4 the FILENAME statement can be simplified;
* filename list pipe %tslit(dir "&depath\in*.sas7bdat" /o:n /b );
  
data _null_;
  infile list truncover
         end=eof;  
  input memname $20.;  
  name = scan(memname,1,'.');
  call symputx(catt('dsn',_n_),name,'l'); 
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
options noxwait;
%appnddsn(lib=WORK)
