* Program4.2.1.sas;
* Defining Positional Paramters;
%macro look(dsn,obs); 
  title1 "data set &dsn";
  proc contents data=&dsn;
    run; 
  title2 "first &obs observations";
  proc print data=&dsn (obs=&obs); 
    run;
%mend look;

