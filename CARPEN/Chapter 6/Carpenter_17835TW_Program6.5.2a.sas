* Program6.5.2a.sas
* Using CALL EXECUTE with a macro call;

%macro prtdsn(dsn=);
   proc print data=&dsn;
   run;
%mend  prtdsn;

data _null_;
   set macro3.dbdir;
   call execute('%prtdsn(dsn='||dsn||')');
   put dsn=;
   run;

