* Program 5.1.3
* Passing values between macros using parameters.;

%macro doboth(indata=,vlist=,cnt=10);
     %sortit(dset=&indata, bylist=&vlist)
     %look(dsn=&indata,obs=&cnt)
%mend doboth;

%macro look(dsn=clinics,obs=);
     title1 "data set &dsn";
     proc contents data=&dsn;
         run;
     title2 "first &obs observations";
     proc print data=&dsn (obs=&obs);
         run;
%mend look;

%macro sortit(dset=biomass,bylist=);
     proc sort data=&dset;
         by &bylist;
         run;
%mend sortit;

proc datasets nolist;
   copy in=macro3 out=work;
      select clinics;
   quit;
options mprint nosymbolgen mlogic;
%doboth(indata=clinics,vlist=lname fname)


