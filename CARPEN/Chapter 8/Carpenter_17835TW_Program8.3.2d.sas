* Program 8.3.2d
* Checking function return codes;

%let rc = %sysfunc(libname(temxx,c:\tempxx));
%put &rc %sysfunc(sysmsg());
