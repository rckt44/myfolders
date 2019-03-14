* Program 7.4.2c.sas
* Using %SYSFUNC to place a date in a title;

data _null_;
   today = put(date(),worddate18.);
   call symputx('dtnull',today);
   run;

title1 "Using Automatic Macro Variable SYSDATE &sysdate";
title2 "Date from a DATA _NULL_ &dtnull";
title3 "Using SYSFUNC %sysfunc(date(),worddate18.)";

options center nodate nonumber;
proc print data=sashelp.class;
run;
