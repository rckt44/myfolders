* Program 9.1.2b.sas
* Assigning macro calls to function Keys;

%macro showRPT(dsn=sashelp.class);
proc report data=&dsn list;
run;
%mend showrpt;

