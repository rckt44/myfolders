* Program 10.4.2c.sas
* Using MAUTOLOCINDES;

options nomautolocdisplay nomautocomploc;

options mautolocindes;
%put %lowcase(ALL UPPER);
title 'Program 10.4.2c Using MAUTOLOCINDES';
proc print data=sashelp.vcatalg(where=(libname='WORK' & memname='SASMACR'));
   var libname memname objname objdesc;
   run;
