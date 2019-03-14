* Program9.8.1.sas
* Using a macro variable within a WHERE;

%let string = %str(    MEDHIS);
%put where trim(dsn)="%left(&string)";
proc print data=macro3.dbdir;
   where trim(dsn)=:"%left(&string)";
   run;
