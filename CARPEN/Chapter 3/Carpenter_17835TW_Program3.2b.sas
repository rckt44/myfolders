* Program3.2b.sas;
* Using a Macro Variable to Comment a Macro Call;

%let debug = *; 
data new;
   set big; 
   ...code not shown...
   run;

%macro debugnew; 
title 'listing for NEW';
proc print data=new (obs=5);
   run;
%mend debugnew;
&debug  %debugnew     * uncomment to use debugnew;

