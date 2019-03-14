* Program 6.2.4
* Showing SQL automatic macro variables;
proc sql noprint;
select lname into :lastnames separated by ',' 
   from macro3.clinics(where=(lname=:'S'));
%let numobs=&sqlobs;
quit;
%put _user_;
