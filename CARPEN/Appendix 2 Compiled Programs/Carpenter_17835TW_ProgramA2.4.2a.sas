* ProgramA2.4.2a.sas;
* A simple macro to print a selected number of observations;

%macro printit(lib, dsn, num); 
   %if &num= %then %let num=max;
   title2 "&lib..&dsn";
   title3 "First &num Observations";
   proc print data=&lib..&dsn(obs=&num);
      run;
%mend printit;

%printit(macro3, clinics, 3)

