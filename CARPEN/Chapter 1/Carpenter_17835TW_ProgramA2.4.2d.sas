* ProgramA2.4.2d.sas;
* Using RUN_MACRO within a FCMP routine.;

options cmplib=(macro3.functions); 

proc fcmp outlib=macro3.functions.utilities;
   subroutine printN(lib $, dsn $,num);
      rc=run_macro('printit',lib,dsn,num);
   endsub;
   run;

%macro printit();  
   %put Executing PRINTIT for &lib &dsn &num; 
   %let lib  = %sysfunc(dequote(&lib));  
   %let dsn  = %sysfunc(dequote(&dsn)); 
   %if &num= %then %let num=max;
   title2 "&lib..&dsn";
   title3 "First &num Observations";
   proc print data=&lib..&dsn(obs=&num);
      run;
%mend printit;

* Demonstrate the execution of the PRINT step
* from within a DATA step;
data _null_;
put '***** Before routine call';
call printn('macro3', 'clinics', 3);
put '***** After routine call';
run;


