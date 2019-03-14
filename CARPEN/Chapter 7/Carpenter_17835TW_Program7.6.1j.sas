* Program 7.6.1j.sas
* Suspending SAS execution using the SLEEP function;

%macro wakeupat(time=);
   %local rc;
   %let rc = %sysfunc(sleep(
                %sysevalf(%sysevalf("&time"dt)-
                 %sysfunc(datetime()))));
%mend wakeupat;

%wakeupat(time=03mar2015:16:47:00)
