* Program9.3c.sas
* Forming a simple hash;
* Double index and a known list of variables;

data _null_;
   set macro3.clinics;
   call symputx(catx('_',lname,fname),catx('|', sex, dob, ht, wt));
   run;

%put &=pope_robert;
%put Birthdate for Robert Pope: %sysfunc(putn(%scan(&pope_robert,2,%str(|)),date9.));
