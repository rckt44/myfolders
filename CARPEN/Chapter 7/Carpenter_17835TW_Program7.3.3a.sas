* Program 7.3.3a.sas
* %SYSEVALF examples;

%let x = %sysevalf(7/3);
%put Using SYSEVALF &=x;
%let x = %sysevalf(7/3,boolean);
%put Using Boolean &=x;
%let x = %sysevalf(7/3,ceil);
%put Using Ceil &=x;
%let x = %sysevalf(7/3,floor);
%put Using Floor &=x;	
%let x = %sysevalf(1/3);	
%put Less than one &=x;
%let x = %sysevalf(1+.);	
%put Handling a missing result &=x;
%let x = %sysevalf(1+.,boolean);	
%put Boolean on a missing result &=x;
