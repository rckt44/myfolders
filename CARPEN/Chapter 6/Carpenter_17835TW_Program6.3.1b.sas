* Program 6.3.1b
* Inserting macro variable values into code using RETAIN;
%let dsn = clinics;
...code not shown...
data subwt;
   set clinics (keep=fname wt);
   retain dset "&dset";
   where wt>80;
   run;


