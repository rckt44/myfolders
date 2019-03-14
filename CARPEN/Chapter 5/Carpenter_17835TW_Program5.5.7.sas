* Program 5.5.7
* Question #7
* Generalize this PROC MEANS step;

proc means data=macro3.clinics noprint;
var ht wt;
output out=stats mean= max= / autoname;
run;

