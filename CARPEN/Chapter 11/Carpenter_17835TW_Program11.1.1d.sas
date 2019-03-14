* Program 11.1.1d.sas
* Processing a horizontal list;

%macro printall;
   %local dsnlist dsncnt j;
   %let dsnlist = ae cm demog;
   %let dsncnt = %sysfunc(countw(&dsnlist));
   %do j = 1 %to &dsncnt;
      title1 "First 10 obs of %qscan(&dsnlist,&j,%str( ))";
      proc print data=%qscan(&dsnlist,&j,%str( ))(obs=10);
      run;
   %end;
%mend printall;
options mprint;
%printall

 
