* Program 5.1.4b
* Controlling program flow through macro calls.;


**** Analysis performed November 23, 2014 ***********;
%MACRO DOIT;
   %SETUP(NEW1,15,32)   * GATHER DATA FOR WORK.NEW1;
   %SETUP(NEW2,33,40)   * GATHER DATA FOR WORK.NEW2;
   %ALL(FINAL.COMBINE)  * COMBINE DATA FOR ANALYSIS;
 
   **** ANALYZE COMBINED DATA  ***********;
   %ANOVA(type=A)       *   ANALYSIS OF VARIANCE (P/C);
%MEND DOIT;
*%DOIT            * CREATE THE ANALYSIS DATA SET;
