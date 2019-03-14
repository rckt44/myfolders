* Program 14.4.sas
* Using recursion to have a macro call itself;
 
%macro fact(n); 
  %if &n > 1 %then %eval(&n * %fact(%eval(&n-1)));  
  %else 1; 
%mend fact;

%put 4 factorial is %fact(4);
