* ProgramA2.4.2b.sas;
* The incorrect way to call a macro from within a FCMP routine.;

options cmplib=(macro3.functions); 

proc fcmp outlib=macro3.functions.utilities;
   subroutine printN(lib $, dsn $,num);
      * This will NOT work! The macro is 
      * executed when the function is compiled;
      %printit(lib,dsn,num);
   endsub;
   run;

data _null_;
call printn(macro3, clinics, 3);
run;


