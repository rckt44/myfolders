* Program 7.4.2b.sas
* Using %SYSFUNC with the PUTN function;

%put &=sysdate9;
%let newdt = %sysfunc(putn("&sysdate9"d,worddate18.));
%put &=newdt;

