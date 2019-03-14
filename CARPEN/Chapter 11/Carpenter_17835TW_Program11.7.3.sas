* Program 11.7.3.sas
* Forcing macro variables into the local table;

%macro UseDSN;
%local dsncnt i;
proc sql noprint;
   select count(dsn)
      into: dsncnt
         from macro3.dbdir;
   %do i = 1 %to &dsncnt;
      %local dsn&i;
   %end;
   select dsn
      into :dsn1 -
         from macro3.dbdir;
   quit;

   %* other code to use the &DSNxx list goes here;
   %put _local_;
%mend usedsn;
%let dsn2 = in the global table;
%usedsn
%put &=dsn2;

