* Program 7.3.1a.sas
* Using the %EVAL function;

%let x=5;
%let y=&x+1;
%let z=%eval(&x+1);
%let zy=%eval(&y);
%put    &=x    &=y    &=z    &=zy;

%* Only integers can be used;
%let a=%eval(&x+1.8);

%* Non-integer results are truncated;
%let d = %eval(7 / 3);
%put &=d;
%let n = %eval(-7 / 3);
%put &=n;

