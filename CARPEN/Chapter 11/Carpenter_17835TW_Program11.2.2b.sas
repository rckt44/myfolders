* Program 11.2.2b.sas
* Using DICTIONARY.COLUMNS;

%macro varlist2(lib=,dsn=);
%local i;
* Collect the variable names;
proc sql noprint;
select distinct name into :varname1-
   from dictionary.columns 
      where (libname=upcase("&lib") &  
             memname=upcase("&DSN"));
quit;

%do i = 1 %to &sqlobs;
   %put &i &&varname&i;
%end;
%mend varlist2;

%varlist2(lib=macro3,dsn=clinics)

