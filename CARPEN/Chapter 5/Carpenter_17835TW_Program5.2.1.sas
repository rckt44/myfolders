* Program 5.2.1
* Conditional Execution;

%macro doboth(indata=,vlist=,cnt=10);
     %if &vlist ne %then %sortit(dset=&indata, bylist=&vlist);
     %else %put SORTIT was not called;
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
options nomprint nosymbolgen nomlogic;
%doboth(indata=clinics,vlist=)


