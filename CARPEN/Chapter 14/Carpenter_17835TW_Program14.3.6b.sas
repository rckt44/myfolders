* Program 14.3.6b.sas
* Writing to the wrong symbol table.;

%macro tryit;
   %let at = var_local_to_tryit; 
   %inside
%mend tryit;

%macro inside;
data _null_;
   call symputx('ininside','inside');
   run;
   %put **All Current Vars;
   %put _user_;  
%mend inside;

%*symdel ininside at;
%tryit
 

