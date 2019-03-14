* Program6.5.1.sas
* Using CALL EXECUTE with non-macro text;

data _null_;
   set macro3.dbdir;
   prc = 'proc print data='||dsn||';run;';
   call execute(prc);
   run;
