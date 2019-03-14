* Program 9.2.2b.sas
* Building a list of named macro variables from data;
data values;
input mvar $ value $;
datalines;
Name   Alfred
Sex    M
Age    14
Height 69
Weight 112.5
run;
%macro mvarlist;
data _null_;
   set values;
   call symputx(mvar,value,'l');
   run;
%put _local_;
%mend mvarlist;
%mvarlist
