* Program 4.5.6
* Chapter 4 Question 6 - Correct any syntax errors;

macro mycopy;

   proc copy in=work  out=master;
        select patients;
   run;

%mend copy;


