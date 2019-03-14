* Program 7.6.1b.sas
* Calculating a factorial value;

%macro fact(n);
  %sysfunc(fact(&n))
%mend fact;  

%put 5! = %fact(5);
