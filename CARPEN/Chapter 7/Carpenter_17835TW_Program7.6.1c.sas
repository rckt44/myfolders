* Program 7.6.1c.sas
* Calculating a combinatorial value;

%macro comb(n,r);
  %sysfunc(comb(&n,&r))
%mend comb;
  
%put The number of combinations of 6 things taken two at a time = %comb(6,2);
