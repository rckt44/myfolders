* Program 10.6.1.sas
* Using %VERIFY;

%let yrcode = 2016CAdwz25;
%let code = %substr(&yrcode,%verify(&yrcode,1234567890));

%put &=yrcode &=code;

%* Same result using the FINDC function;
%put Code using FINDC %substr(&yrcode,%sysfunc(findc(&yrcode,,dik)));
