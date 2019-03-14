* Program9.8.4.sas
* Working with a list;

%let string = %str(   )MEDHIS K, L, and M;
%put |&string|;

%* When &STRING is resolved, the commas are seen as parameter separators;
%put where trim(dsn)=:"%left(&string)";

%* Mask commas with %BQUOTE;
%put where trim(dsn)=:"%left(%bquote(&string))";

%* Mask commas with %SUPERQ;
%put where trim(dsn)=:"%left(%superq(string))";

proc print data=macro3.dbdir;
   where trim(dsn)=:"%left(%superq(string))";
   run;
