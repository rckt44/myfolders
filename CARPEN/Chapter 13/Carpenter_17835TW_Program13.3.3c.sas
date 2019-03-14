* Program 13.3.3c.sas
* Randomly selecting the data subset with replacement;

%macro rand_w(dsn,numobs=0,pcnt=0);  

* Randomly select either a specified number of
* observations or a percentage from a data set.
*
* Sample WITH replacement;
*       any observation can be selected any number of
*       times.

* When NUMOBS is specified create a subset of exactly
* that many observations (ignore PCNT).
* When PCNT is specified (and NUMOBS is not)
* calculate NUMOBS using PCNT*total number in DSN.
*;

* Randomly select &NUMOBS observations from &DSN;
data rand_w;
retain numobs .;
drop numobs i;

* Create a variable (NUMOBS) to hold number of obs
* to write to RAND_W;
%if &pcnt ne 0 and &numobs=0 %then %do; 
   * Use the percent to calculate a number of obs;
   numobs = round(nobs*&pcnt); 
%end;
%else %do;
   numobs = &numobs; 
%end;

* Loop through the SET statement NUMOBS times;
do i = 1 to numobs;
   * Determine the next observation to read;
   point = ceil(ranuni(0)*nobs);  

   * Read and output the selected observation;
   set &dsn point=point nobs=nobs  ; 
   output rand_w;  
end;
stop;
run;
%mend rand_w;
%rand_w(dsn=macro3.clinics,pcnt=.25)
%rand_w(dsn=macro3.clinics,numobs=150)
