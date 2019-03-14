* Program 12.4.8b.sas
* Convert a character variable to a formatted value;

%macro applyfmt(dsn=,var=,fmt=,chktype=);
   %* Make sure the format is present;
   %if &fmt = %then %do;
      %put ERROR: Format is missing for a FIXRAW request;
      %put ERROR- &=DSN &=var;
      %return;
   %end; 

   %* Make sure that the format has a period;
   %if %index(&fmt,.)=0 %then %let fmt=&fmt..;

   data &dsn;
      set &dsn;
      &var = put(&var,&fmt);
   run;
%mend applyfmt;

