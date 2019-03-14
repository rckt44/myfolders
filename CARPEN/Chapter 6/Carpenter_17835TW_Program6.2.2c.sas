* Program 6.2.2c
* Storing unformatted values;
proc sql noprint;
select dob  format=6.
   into :dobirths separated by ','
      from macro3.clinics(where=(lname=:'S'));  
   quit;
%put &=dobirths;
title1 '6.2.2c Selected patients';
proc print data=macro3.clinics;
   where dob in(&dobirths);
   var lname fname dob;
   run;


