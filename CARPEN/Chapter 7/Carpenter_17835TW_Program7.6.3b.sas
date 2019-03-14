* Program 7.6.3b.sas
* Creating a grouping variable;

/*************************************************** 
Macro EOW               Garth Helf   24 October 2003 
Create new variable in a DATA step containing week 
ending date for a SAS date variable.  Argument we_day 
is day the week starts:  
     1=Sunday (default) to 7=Saturday. 
****************************************************/ 
%macro eow(dayvar=magdate,  eowvar=magweek, 
           eowformt=date9., we_day=1);
   &eowvar=intnx("week.&we_day", &dayvar, 0,"end");
   format &eowvar &eowformt; 
%mend eow;

data biomass;
 set macro3.biomass;
 %eow(dayvar=date, eowvar=sampledate, we_day=7)
 weekday = weekday(sampledate);
 run;
title1 'Program 7.6.3b Grouping';
proc print data=biomass;
   var date sampledate weekday bmtotl;
   run;
