* Program 7.6.1g.sas
* Suspending SAS execution;

%macro sleep(time=5);
   %local rc;
   %let rc = %sysfunc(sleep(&time));
%mend sleep;

%sleep(time=10) 

