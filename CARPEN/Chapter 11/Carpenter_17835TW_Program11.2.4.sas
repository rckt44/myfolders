* Program 11.2.4.sas
* Using the GETOPTION function;

/*********************************************************/
/* Macro: HoldOpt */
/* Programmer: Pete Lund */
/* Date: September 2000 */
/* Purpose: Holds the value of a SAS option in a macro */
/* variable. The value can then be used to reset options */
/* to a current value if changed. */
/* */
/* Parameters: */
/* OptName   the name of the option to check */
/* OptValue   the name of the macro variable that will */
/* hold the current value of the option */
/* The default name is made up of the word */
/* "Hold" and the option name. For */
/* example, if OptName=Notes, OptValue */
/* would equal HoldNotes */
/* Display   Display current value to the log (Y/N) */
/* The default is N */
/* */
/*********************************************************/
%macro HoldOpt(
          OptName=,    /* Option to hold value   */  
          OptValue=XX, /* Macro var name to hold value*/ 
          Display=N);  /* Display value to the log */

%if %substr(&sysver,1,1) eq 6 
   and ((%length(&OptName) gt 4 and &OptValue=XX) 
      or %length(&OptValue) gt 4) %then %do;
   %put WARNING: Default variable name of Hold&OptName is too long for V&sysver..;
   %put WARNING: Please specify a shorter name with the OptValue= macro parameter.;
   %goto Quit;
%end;
%if &OptValue eq XX %then %let OptValue = Hold&OptName; 
%global &OptValue; 
%let &OptValue = %sysfunc(getoption(&OptName)); 
%if &Display eq Y %then
   %put The current value of &OptName is &&&OptValue;
%Quit:
%mend;

%* Sample uses of the HOLDOPT macro;
%HoldOpt(OptName=date)
   %put &=holddate;
%HoldOpt(OptName=obs, display=Y)
%HoldOpt(OptName=ls, OptValue=myls)
   %put &=myls;
