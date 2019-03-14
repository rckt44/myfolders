* Program 6.4.1a 
* Pulling macro variables from data;

%macro look;
   data _null_;
      set control;
      call symputx('dsn',dsname,'l'); 
      call symputx('obs',nobs,'l');
      run;
   title1 "Contents of &dsn";
   proc contents data=&dsn;
      run;
   title1 "First &obs Observations of &dsn";
   proc print data=&dsn (obs=&obs);
     run;
%mend look;

data control;
   dsname='macro3.clinics';
   nobs=5;
   run;
%look
