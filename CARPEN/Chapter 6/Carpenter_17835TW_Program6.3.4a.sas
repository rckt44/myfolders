* Program 6.3.4a
* Retrieving a numeric value from a macro variable;
 
%let test=5;
data b;
   w = &test;
   x = symget('test');
   y = resolve('&test');
   run;
proc contents data=b;
   run;
proc print data=b;
   run;
