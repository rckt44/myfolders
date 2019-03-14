* Program 11.1.3a.sas
* Identify data dependencies;

title1 'Summary of Height and Weight';
proc summary data=macro3.clinics;
   class region;
   var ht wt;
   output out=sumry n= mean= stderr=/autoname;
   run;
proc print data=sumry;
   run;
