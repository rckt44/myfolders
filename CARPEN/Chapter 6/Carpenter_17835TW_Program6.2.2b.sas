* Program 6.2.2b
* Storing multiple comma separated lists;
proc sql noprint;
select lname, dob 
   into :lastnames separated by ',', 
        :dobirths separated by ','
      from macro3.clinics(where=(lname=:'S')); 
%let numobs=&sqlobs; 
quit;
%put lastnames are: &lastnames;
%put dobirths are: &dobirths;
%put number of names is: &numobs;


