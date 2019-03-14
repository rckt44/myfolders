* Program 11.9.1b.sas
* Taking the mean and n for WT and HT for each gender;

proc summary data=macro3.clinics;
   class sex;
   var ht wt;
   output out=summary
          n=  
          mean= /autoname;
   run;
title '11.9.1b Consistent naming using AUTONAME';
proc print data=summary;
   run;
