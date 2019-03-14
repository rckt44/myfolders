* Program9.8.2.sas
* Passing quote marks;

%let string = %str(     MEDHIS "aka G");

%* The resolved text has multiple double quotes;
%put where trim(dsn)=:"%left(&string)";

%* %BQUOTE will not help;
%put where trim(dsn)=:"%left(%bquote(&string))";

%* Using single quotes on the outside masks the macro triggers;
%put where trim(dsn)=:'%left(&string)';

%* delay the parsing of the outer single quotes;
%put where trim(dsn)=:%unquote(%bquote(')%left(&string)%bquote('));

proc print data=macro3.dbdir;
   where trim(dsn)=:%unquote(%bquote(')%left(&string)%bquote('));
   run;

%* Using the SAS9.4 TSLIT autocall macro function;
%put where trim(dsn)=:%tslit(%left(&string));
