* Program 7.6.1h.sas
* Suspending SAS execution;

%macro sleep(time=5);
   %sysfunc(sleep(&time))
%mend sleep;

%put WARNING: Computer slept for %sleep(time=15) seconds; 
