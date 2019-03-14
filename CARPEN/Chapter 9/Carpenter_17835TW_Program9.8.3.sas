* Program9.8.3.sas
* Masking & and % signs;

%let string = %str(    MEDHIS H&J);

%* When &STRING is resolved, &J is seen as a macro variable reference;
%put where trim(dsn)=:"%left(&string)";

%* Mask with %SUPERQ;
%put where trim(dsn)=:"%left(%superq(string))";

%* Mask with %SUPERQ and %QLEFT;
%put where trim(dsn)=:"%qleft(%superq(string))";


proc print data=macro3.dbdir;
   where trim(dsn)=:"%qleft(%superq(string))";
   run;
