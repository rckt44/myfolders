* Program 7.3.1b.sas
* Using the %EVAL function with the IN operator;

%* When the IN operator is used outside of the 
%* %IF statement, an explicit %EVAL is required;
options minoperator;
%* This %PUT works;
%put %eval(CA in WA CA);
%* This %PUT fails;
%put %eval(CA in OR CA IN NE WA);

%let state = CA;
%let list = CA WA ID NV;
%let inlist = %eval(&state in &list);
%put &=inlist;

%let state = CA;
%let list = OR CA IN NE WA ;
%let inlist = %eval(&state in &list);
%put &=inlist;
%let inlist = %eval(&state in %bquote(&list));
%put &=inlist;
