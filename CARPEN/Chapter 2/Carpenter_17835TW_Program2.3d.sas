* Program 2.3d	   Using &DEBUG to Comment Code;
%let dsn = clinics;
%let debug =*;
&debug title "Data Set &dsn";
&debug proc contents data=&dsn;
&debug    run;
&debug proc print data=&dsn (obs=10);
&debug    run;
