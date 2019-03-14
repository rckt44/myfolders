* Program 6.4.2b
* Passing the names of macro variabls rather than the values;

%macro look(dat=,cnt=);
     title "Contents of &&&dat";
     proc contents data=&&&dat;
     run;
     title2 "Showing the first &&&cnt Observations";
     proc print data=&&&dat (obs=&&&cnt);
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

* The SYMPUTX is shown in a separate step here
* although in this little example it could
* have also been included in the previous DATA step.;
data _null_;
     set control;
     call symputx(mvarname,value,'l');
run;
%look(dat=dsn,cnt=obs)
