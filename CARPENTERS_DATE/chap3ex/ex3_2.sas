DATA informats_are_smart;
INPUT @1 date1 MMDDYY10.;
unformatted_date = date1;
DATALINES;
10/17/2014
05-04-59
3-1-1940
run;

ods rtf file="informats_are_smart.rtf";
proc print;
format date1 worddatx. ;
RUN;
ods rtf close;
