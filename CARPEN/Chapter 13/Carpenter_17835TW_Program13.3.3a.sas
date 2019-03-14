* Program 13.3.3a.sas
* Randomly selecting the data subset;

%macro rand_wo(dsn=,pcnt=0);

* Randomly select an approximate percentage of
* observations from a data set.
*
* Sample WITHOUT replacement;
*       any given observation can be selected only once
*       all observations have equal probability of selection.
*;

* Randomly select observations from &DSN;
data rand_wo;
   set &dsn;
   if ranuni(0) le &pcnt then output rand_wo; 
   run;
%mend rand_wo;
%rand_wo(dsn=macro3.clinics,pcnt=.25)
