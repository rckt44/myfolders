* Program 6.6.1
* Storing numeric values in a macro variable using SQL;

proc sql noprint;
select min(weight)
   into :mwt
      from sashelp.class;
select min(weight)
   into :mwt1 -
      from sashelp.class;
quit;
%put |&mwt|;
%put |&mwt1|;
