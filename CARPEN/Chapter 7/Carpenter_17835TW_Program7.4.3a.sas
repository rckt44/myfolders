* Program 7.4.3a.sas
* Using %SYSFUNC to determine  a path;

%macro engchng(libref=sasuser,
               engine=v6,
               dsn=);
* libref - library containing the data set(s) of interest
* engine - output engine for this &dsn
* dsn    - name of data set to copy
*;

* Create a libref for the stated Engine;
libname dbmsout clear;
libname dbmsout &engine "%sysfunc(pathname(&libref))";

* Copy the SAS data set(s) using the alternate engine;
proc datasets nolist;
  copy in=&libref out=dbmsout;
    select &dsn;
  run;
  quit;
libname dbmsout clear;
%mend engchng;

***************************************************;
%engchng(libref=macro3,engine=excel,dsn=biomass clinics)  
