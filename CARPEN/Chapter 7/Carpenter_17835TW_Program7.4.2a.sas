* Program 7.4.2a.sas
* Using a DATA _NULL_ step to create a macro variable;

data _null_;
date = put("&sysdate9"d,worddate18.);
call symputx('newdt',date);
run;
%put &=newdt;

