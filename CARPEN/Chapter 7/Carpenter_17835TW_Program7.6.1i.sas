* Program 7.6.1i.sas
* Suspending SAS execution;

%macro sleep(time=5,unit=seconds);
   %* Units can be seconds, minutes, or hours;
   %local timeval;

   %if &unit eq %then unit=seconds;
   %if %upcase(&unit)=SECONDS %then %let timeval=1;
   %else %if %upcase(&unit)=MINUTES %then %let timeval=60;
   %else %if %upcase(&unit)=HOURS   %then %let timeval=3600;

   %sysfunc(sleep(&time,&timeval))
%mend sleep;

%put WARNING: Computer slept for %sleep(time=1,unit=minutes) seconds; 
