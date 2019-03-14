* Program 8.1.1d.sas
* Using the %SYSGET function to retrieve a program path;

%put %sysget(sas_execfilepath);

%macro grabpath ;
   %* return the path of the currently executing program;
   %qsubstr(%sysget(SAS_EXECFILEPATH),
            1,
            %length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILEname))
            )
%mend grabpath;

%put %grabpath;

footnote1 justify=c "The path to the executing program is: %grabpath";
proc print data=sashelp.class;
run;

