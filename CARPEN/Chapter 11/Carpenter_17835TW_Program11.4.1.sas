* Program 11.4.1.sas
* Use Control information to build a horizontal list of values;

proc sql noprint;
   select distinct dsn
      into :dsnlist separated by ' '
         from macro3.dbdir;
   %let dsncnt = &sqlobs;
   quit;

%put &=dsncnt;
%put &=dsnlist;
