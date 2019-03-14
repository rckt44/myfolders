* Program 5.1.2
* Passing values between macros.;

%macro doboth;
     %sortit(dset=clinics, bylist=lname fname)
     %look(obs=10)
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

%doboth


