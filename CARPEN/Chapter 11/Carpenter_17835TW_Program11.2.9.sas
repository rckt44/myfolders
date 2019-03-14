* Program11.2.9.sas;
* Using the NOBS= option on the SET statement;

%macro numobs(dsn=);
data _null_;
   call symputx('numobs', dsnobs);  
   stop;  
   set &dsn nobs=dsnobs;  
   run;
%mend numobs;
%numobs(dsn=macro3.clinics)
%put The number of observations in MACRO3.CLINICS is &numobs;





