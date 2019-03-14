* Program3.2a.sas;
* Commenting a Macro Call;
data new;
   set big; 
   ...code not shown...
   run;

%macro debugnew; 
title 'listing for NEW';
proc print data=new (obs=5);
   run;
%mend debugnew;
*%debugnew    * uncomment to use debugnew;
