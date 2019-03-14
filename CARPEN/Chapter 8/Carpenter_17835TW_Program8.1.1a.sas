* Program 8.1.1a.sas
* Using the %SYSGET function to retrieve an environmental variable;

* Location of the autocall library;
%put %sysget(sasautos);

* Current environmental variables set in the configuration file;
proc print data=sashelp.voption(where=(optname='SET'));
run;

* return the path to the SAS.EXE file.;
%let sasloc = %sysget(sasroot)\sas.exe;
%put &=sasloc;

