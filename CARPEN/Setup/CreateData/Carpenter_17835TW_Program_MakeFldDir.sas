* MakeFldDir.sas
* Create the list of variables and their checks;

data macro3.FldDIR;
infile cards truncover;
input dsn $8. @10 Var $8. @20 ChkType $8. @31 ChkText $20.;
Datalines;
DEMOG    CENTER    notmiss
DEMOG    RACE      list       ('1','2','3')
MEDHIS   MHDT      format     date9.
MEDHIS   SUBJECT   equals     medhisno
run;
proc print data=macro3.flddir;
run;
