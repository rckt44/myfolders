* Program 6.3.1a
* Inserting macro variable values into code;
%let dsn = clinics;
...code not shown...
data subwt;
   set clinics (keep=fname wt);
   dset = "&dsn";
   where wt>80;
   run;

