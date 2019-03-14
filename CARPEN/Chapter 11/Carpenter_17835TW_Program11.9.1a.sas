* Program 11.9.1a.sas
* Taking the mean and n for WT and HT for each gender;

proc summary data=macro3.clinics;
   class sex;
   var ht wt;
   output out=summry
          n= n_ht weight_n
          mean= mHT Mean_wt;
   run;
title '11.9.1a Inconsistent naming of variables';
proc print data=summry;
   run;
