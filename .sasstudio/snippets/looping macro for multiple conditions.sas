
options symbolgen mprint mlogic;
%macro hitit;
data a;
set sashelp.class;
run;

proc sql noprint;
select distinct age into:age1- from a;
/* select disticnt make into:makers1 from a;--incase you make cars yours dataset */
quit;
%let last=&sqlobs;
/* %do i=1 %to &total; */
/* %put &i=&&makers&i; */
/* %end; */

%do i=1 %to &last;
proc print data=a;
/* here you have to use quote coz make such as audi,toyota,bmw is character functions, */
/* where is age(from class)in numeric ,so not required. */
/* where make="&&makers&i"; */
where age=&&age&i;
run;
%end;
%mend hitit;
%hitit;
