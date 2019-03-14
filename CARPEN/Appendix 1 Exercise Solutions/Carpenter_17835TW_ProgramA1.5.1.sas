* Program A1.5.1
* Question #1
* Execute PROC PRINT for MACRO3.CLINICS;

%macro printt(dsin,proc=);
     proc &proc data=&dsin;
     run;
%mend printt;

%printt(macro3.clinics,proc=print)
%printt(dsin=macro3.clinics,proc=print)
%printt(proc=print,dsin=macro3.clinics)
