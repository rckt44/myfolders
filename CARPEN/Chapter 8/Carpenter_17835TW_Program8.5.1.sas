* Program8.5.1.sas
* Testing timing when using the DOSUBL function;

%macro test;
data _null_;
   put 'Calling SYMPUTX'; 
   call symputx('x3',100); 
   run;

%put Ready to compile DATA step for NEW; 
data new;
   %put Compiling NEW; 
   put 'Executing NEW'; 
   y = &x3; 
   run;
title 'Data NEW';
proc print data=new;
   run;
%mend test;

data _null_;
   rc= dosubl('%test');
   put rc=;
   run;


