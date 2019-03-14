* Program 6.3.2a
* Retrieving a macro variable using SYMGET;
%let dsn = clinics;

data subwt;
   set &dsn(keep=fname wt);
   where wt>80;
   dataset=symget('dsn');
   dset = "&dsn";
   run;



