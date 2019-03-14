* Program 6.6.5
* Use CALL EXECUTE to execute the %SPRPT macro
* once for each specie in the SPLIST data set;

data splist;
   infile datalines truncover;
   input species $9.;
   datalines;
Parkki
Perch
Pike
run;
%macro splist(sp=);
title1 "Average Weight of &sp";
proc means data=sashelp.fish n mean;
   where species="&sp";
   var weight;
   run;
%mend splist;
