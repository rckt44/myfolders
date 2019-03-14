* Program 8.3.4
* Showing &SYSNOBS;

proc sql;
quit;

data want;
   set sashelp.class(where=(name>'B'));
   run;
%put &=sysnobs;
%* &SQLOBS is not reset with the DATA step;
%put &=sqlobs;

* a SQL step does not reset &SYSNOBS;
proc sql;
create table b as
   select name, age
      from sashelp.class
         where name>'B';
   quit;
%put &=sysnobs;
%put &=sqlobs;

data girls;
   * data set does not exist;
   set wannnnnnt(where=(sex='F'));
   run;
%put &=sysnobs;
%put &=sqlobs;

data girls boys;
   set sashelp.class;
   if sex='M' then output boys;
   else if sex='F' then output girls;
   run;
%put &=sysnobs;
