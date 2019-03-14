* Program 8.1.1c.sas
* Using the %SYSGET function to retrieve a program name;

%put %sysget(sas_execfilename);

Footnote1 justify=c "The executing program is: %sysget(sas_execfilename)";
proc print data=sashelp.class;
run;

