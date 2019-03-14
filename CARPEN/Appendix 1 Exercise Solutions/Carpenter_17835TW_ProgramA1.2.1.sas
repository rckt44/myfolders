* Program A1.2.1
* Chapter 2 Question 1 solution;

%let dsn = clinics;
%let var1 = edu;
%let var2 = sex;

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
