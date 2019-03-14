* Program 6.2.3b
* Creating a numbered list of macro variables;
%macro varlist(dsn=);
%local i;
* Determine the list of variables in this 
* base data set;
proc contents data= &dsn 
              out= cont noprint; 
   run;

* Collect the variable names;
proc sql noprint;
   select distinct name
     into :varname1-:varname&sysmaxlong
       from cont;
   quit;

%do i = 1 %to &sqlobs;
   %put &i &&varname&i;
%end;
%mend varlist;

%varlist(dsn=macro3.clinics)
