* Program 6.3.5a 
* Concatenating a list of values in a SQL step;

%let lastnames=;
proc sql noprint;
   select lname
      into :lastnames separated by '|'
         from macro3.clinics;
quit;
%put &=lastnames;
