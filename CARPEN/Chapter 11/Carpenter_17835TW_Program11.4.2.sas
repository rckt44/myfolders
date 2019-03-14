* Program 11.4.2.sas
* Building and parsing a horizontal list of values;

%macro listdsn;
%local dsnlist dsncnt i;
proc sql noprint;
   select distinct dsn
      into :dsnlist separated by ' '
         from macro3.dbdir;
   %let dsncnt = &sqlobs;
   quit;
%do i = 1 %to &dsncnt;
   %put &=i %qscan(&dsnlist,&i,%str( ));
%end;
%mend listdsn;
%listdsn
