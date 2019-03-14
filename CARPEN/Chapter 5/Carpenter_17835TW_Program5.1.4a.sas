* Program 5.1.4a
* Controlling program flow through macro calls.;

...code not shown...
***************************************;
**** CREATE DATA AS REQUIRED***********;
%MACRO DOIT;
   %SETUP(NEW1,15,32)   * GATHER DATA FOR WORK.NEW1;
   %SETUP(NEW2,33,40)   * GATHER DATA FOR WORK.NEW2;
  %*SETUP(NEW3,41,72)   * GATHER DATA FOR WORK.NEW3;
   %ALL(FINAL.COMBINE)  * COMBINE DATA FOR ANALYSIS;
%MEND DOIT;
%DOIT          * CREATE THE ANALYSIS DATA SET;
 
**** ANALYZE COMBINED DATA  ***********;
%CORREL                 * CORRELATION OF P/C VARS;
%ANOVA                  * ANALYSIS OF VARIANCE (P/C);
