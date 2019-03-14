* Carpenter_17835TW_Program 2.5.2d.sas;
* Following a macro variable with a dot 
* in the resolved code.;
%let lib = macro3;
%let dsn = clinics;

title "Looking at &lib..&dsn";
proc contents data= &lib..&dsn;
   run;

proc print data= &lib..&dsn;
   run;




