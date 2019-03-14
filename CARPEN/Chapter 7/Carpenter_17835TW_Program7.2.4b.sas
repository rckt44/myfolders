* Program 7.2.4b.sas
* Demonstrating the %SUBSTR and %QSUBSTR functions;

%let dsn=clinics;
%let string = %nrstr(*&stuff*&dsn*&morestuf);

%let sub = %substr(&string,9,5);
%let qsub = %qsubstr(&string,9,5);

%put &=sub &=qsub;

