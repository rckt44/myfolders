* Program8.3.6.sas
* Library return codes;

* This library location does not exist;
libname mytemp "c:\temploc";
%put Zero is success: &syslibrc;

%* you CAN reset the value - but only to an integer;
%let syslibrc=25.25;
%put &=syslibrc;

data _null_;
* LIBNAME function does NOT reset &SYSLIBRC;
rc = libname('mytemp','c:\temploc');
put rc=;
run;
%put Zero is success: &syslibrc;

%* Using %SYSFUNC with the LIBNAME function;
%* &SYSLIBRC is not reset;
%let rc = %sysfunc(libname(mytemp,c:\temploc));
%put &=rc &=syslibrc;


