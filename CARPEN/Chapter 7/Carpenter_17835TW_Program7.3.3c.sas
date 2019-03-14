* Program 7.3.3c.sas
* Creating SAS date and time values using %SYSEVALF;

%let time = 18nov2015:12:25:10;
%put &=time;
%put %sysevalf("&time"dt);
%let date = %sysevalf('31oct2015'd);
%put &=date;
