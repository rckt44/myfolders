* Program 4.5.3 
* Exercise Program;
*******************************************************;
**** The class data set, CLINICS,  contains 80     ****;
**** observations and 20 variables.  The following ****;
**** program will be used to complete Exercise 3   ****;
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
