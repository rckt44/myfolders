* Program 14.6.2.sas
* Saving macro variables across sessions;

%macro GlobalSave(scope=global,macdsn=);
%* Save global macro variables
%*    scope    global      user defined global macro variables (default)
%*             automatic   system generated automatic macro variables
%*    macdsn   Data set to contain the macro variable values
%* ****************;
data &macdsn;
   set sashelp.vmacro(where=(scope="%upcase(&scope)") );
   run;
%mend globalsave;
%globalsave(scope=global,macdsn=macro3.GlobalMacroVars)
 


%macro GlobalRetrieve(scope=global, macdsn=);
data _null_;                                                                                                                           
   set &macdsn(where=(scope="%upcase(&scope)"));                                                                                                   
   call symputx(name,value,'g');
   run;
%mend globalretrieve;
%globalretrieve(scope=global, macdsn=macro3.globalmacrovars)
