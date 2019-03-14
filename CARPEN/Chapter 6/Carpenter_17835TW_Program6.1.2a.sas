* Program 6.1.2a
* Comparing SYMPUTX to SYMPUT
* Numeric second argument;
data _null_;
x=5;

call symput('x1',x);
call symput('x2',trim(left(put(x,6.))));
call symputx('x3',x);
run;
%put The vertical bars show leading and trailing blanks.;
%put Using SYMPUT X1 is |&x1|;
%put Using SYMPUT with TRIM LEFT PUT X2 is |&x2|;
%put Using SYMPUTX X3 is |&x3|;

 
