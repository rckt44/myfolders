* Program 6.4.2a
* Using data to both name the macro variable 
* and assign a value;

%macro look;
     data _null_;
          set control;
          call symputx(mvarname,value,'l');
     run;
     title "Contents of &dsn";
     proc contents data=&dsn;
     run;
     title2 "Showing the first &obs Observations";
     proc print data=&dsn (obs=&obs);
     run;
%mend look;

data control;
     mvarname='dsn';
     value='macro3.clinics';
     output;
     mvarname='obs';
     value=5;
     output;
run;
%look
