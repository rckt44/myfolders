* Program A1.5.7
* Question #7
* Generalize a PROC MEANS step;

%macro mymeans(dsn=,    varlst=, statlst= mean max, 
               outdsn=, print=noprint);
proc means data=&dsn &statlst 
  %if &outdsn = %then print; 
  %else &print;
   ; 

var &varlst;
%if &outdsn ne %then %do;
  output out=&outdsn mean= max= / autoname;
%end; 
run;
%mend mymeans;

* print selected stats (no output data set);
%mymeans(dsn=macro3.clinics, 
         varlst=ht wt, 
         statlst=mean stderr)

* no printed stats (output data set only);
%mymeans(dsn=macro3.clinics, 
         varlst=ht wt,
         outdsn=outstat)
proc print data=outstat;
run;

* printed stats & an output data set ;
%mymeans(dsn=macro3.clinics, 
         varlst=ht wt,
         statlst=sum max,
         outdsn=outstat,
         print=print) 
