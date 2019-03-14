* Program A1.4.3a
* Chapter 4 Question 3a solution;

%macro reportit(dsn,var1,var2);
title1 'Counts of Gender vs. Years of Education';
proc tabulate data=macro3.&dsn;
   class &var2 &var1;
   table &var2=' ',&var1*n=' '/box=&var2;
   run;

title1 'Statistics on Heights for Each Gender';
proc univariate data=macro3.clinics;
   class &var2;
   var ht;
   run;
%mend reportit;

%reportit(clinics,edu,sex)
