* Program 11.2.6b.sas
* Using PROC CONTENTS to access the meta-data;

%macro dsncnt(lib); 
proc contents data=&lib.._all_
              out=cont
              noprint;
   run;
data _null_;
   set cont;
   by memname;
   if first.memname then call symputx(memname,nobs,'l');
   run;
%put _local_;
%mend dsncnt;
%dsncnt(macro3)
