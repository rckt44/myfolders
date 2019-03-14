* Program 11.1.3b.sas
* Replace data dependencies with macro variables;

%macro sumry(dsn=,classlst=,varlst=);
title1 "Summary of &varlst";
proc summary data=&dsn;
   class &classlst;
   var &varlst;
   output out=sumry n= mean= stderr=/autoname;
   run;
%mend sumry;
%sumry(dsn=sashelp.shoes,classlst=region subsidiary,varlst=sales)
proc print data=sumry;
   run;
