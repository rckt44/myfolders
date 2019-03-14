* Program 5.5.1
* Question #1
* Execute PROC PRINT for MACRO3.CLINICS;

%macro printt(dsin,proc=);
     proc &proc data=&dsin;
     run;
%mend printt;
