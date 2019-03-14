* Program A1.3.1
* Chapter 3 Question 1 solution;

%let dsn = clinics;
%let var1 = edu;
%let var2 = sex;
%macro reportit;
title1 'Counts of Gender vs. Years of Education';
proc tabulate data=macro3.&dsn;
   class &var2 &var1;
   table &var2=' ',&var1*n=' '/box=&var2;
   run;

title1 'Statistics on Heights for Each Gender';
proc univariate data=macro3.&dsn;
   class &var2;
   var ht;
   run;
%mend reportit;

%reportit
