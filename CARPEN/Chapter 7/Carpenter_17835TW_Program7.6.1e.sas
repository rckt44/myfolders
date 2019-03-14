* Program 7.6.1e.sas
* Formatting today as a DB2 datetime value;

%macro db2date;
   %unquote(%bquote(')%sysfunc(date(),yymmddd10.)%bquote(-00.00.00'))
%mend db2date;

%put Today is |%db2date|;

/* usage in a SQL pass through to a DB2 server
proc sql;
 connect to odbc (&db2j);
 create table sincemidnight 
   as select * from connection to odbc (
     select *
      from mydba.hospital1
       where proddate > %db2date
       for fetch only);
 %put &sqlxmsg;
 disconnect from odbc;
 quit;
*/
