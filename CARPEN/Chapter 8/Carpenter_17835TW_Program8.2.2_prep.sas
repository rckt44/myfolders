* Program 8.2.2_prep.sas
* Create the datasets used in 8.2.2;

data male female;
   set macro3.clinics;
   if sex='F' then output female;
   else output male;
   run;

