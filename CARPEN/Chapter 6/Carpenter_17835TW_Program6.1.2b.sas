* Program 6.1.2b
* Comparing SYMPUTX to SYMPUT
* Using the third argument of SYMPUTX;
%macro placeit(val=);
data _null_;
string="&val";
call symput('c1',string);
call symputx('c2',string);
call symputx('c3',string,'f');
call symputx('c4',string,'g');
call symputx('c5',string,'l');
run;
%put _user_;
%mend placeit;
%let c3=inglobal;
%placeit(val=clinics)
