* Program 8.3.2e
* CheckingSQL step boundaries;

proc sql ;
%put &=sqlrc;
create table class as
   select *
      from sashelp.clss;
%put &=sqlrc;
create table class as
   select *
      from sashelp.class;
%put &=sqlrc;
quit;

* Checking other SQL automatic macro variables;
proc sql noprint;
  * reset inobs=3;
   create table class as select * from sashelp.clss;
quit;

%put _global_;
