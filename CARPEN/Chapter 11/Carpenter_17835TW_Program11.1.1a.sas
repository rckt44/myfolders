* Program 11.1.1a.sas
* Creating and using a vertical list;

%let dsn1 = ae;
%let dsn2 = cm;
%let dsn3 = demog;
%let dsncnt = 3;

%macro printall;
   %do j = 1 %to &dsncnt;
      proc print data=&&dsn&j;
      run;
   %end;
%mend printall;

 
