* Program1.2.1.sas;
* A simple example of the use of macro variables;
%let dsn = sashelp.class;
%let cnt = 5;

proc print data=&dsn(obs=&cnt);
   run;
