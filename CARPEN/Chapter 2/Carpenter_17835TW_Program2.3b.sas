* Program 2.3b	A Generalized SAS Program;
%let dsn = clinics; 

title "data set &dsn"; 
proc contents data=&dsn; 
   run;

proc print data=&dsn (obs=10);
   run;

