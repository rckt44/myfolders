* Program 2.0.sas  Create WORK.CLINICS;
title1 'Copy Data Set clinics';
proc datasets library=macro3 nolist;
   copy out=work;
      select clinics;
quit;
