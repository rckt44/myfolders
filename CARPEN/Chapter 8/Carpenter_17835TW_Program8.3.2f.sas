* Program 8.3.2f
* Show error and warning text;

proc compare data=sashelp.shoes comp=sashelp.class;
run;
%put &=syserr;
%put &=sysinfo;
