* Program 12.2.3.sas
* Consolidating OUTPUT data sets across procedures with MATCH_ALL;

proc datasets library=work nolist kill;
   quit;

ods output Moments(match_all=namelist 
                   persist=proc)=work.Moments;

proc sort data=sashelp.class out=class;
   by age;
   run;

proc univariate data=class;
   by age;
   var weight;
   run;
proc sort data=sashelp.class out=class;
   by sex;
   run;
proc univariate data=class;
   by sex;
   var weight;
   run;
ods output close;
%put &=namelist;
data allmoments;
   set &namelist;
   run; 
