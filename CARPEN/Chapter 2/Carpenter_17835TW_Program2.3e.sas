* Program 2.3e    Using &DEBUG to Comment Code;
%let dsn = clinics; 
%let debug = /; 
&debug* *;    
title "data set &dsn";      
proc contents data=&dsn;  
   run;    
proc print data=&dsn (obs=10);    
   run; 
*/ *;