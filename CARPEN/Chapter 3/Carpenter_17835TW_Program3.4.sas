* Program3.4.sas;
* Exercise program;
*******************************************************;
**** The class data set, CLINICS,  contains 80     ****;
**** observations and 20 variables.  The following ****;
**** program can be used to complete the exercises ****;
**** in this chapter.                              ****;
*******************************************************;

title1 'Counts of Gender vs. Years of Education';
proc tabulate data=macro3.clinics;
   class sex edu;
   table sex=' ',edu*n=' '/box=sex;
   run;

title1 'Statistics on Heights for Each Gender';
proc univariate data=macro3.clinics;
   class sex;
   var ht;
   run;
