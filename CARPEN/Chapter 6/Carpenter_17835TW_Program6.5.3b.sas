* Program6.5.3b.sas
* Testing timing when using CALL EXECUTE;

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
   call execute('%test');
   run;


