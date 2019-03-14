* MakeVarDIR.sas
* Create the list of variables and attributes;

data macro3.VarDir;
infile cards truncover;
input dsn $8. @11 Var $8. @20 VarType $4. @30 Label $25.;
Datalines;
ALL       SUBJECT  $8        Patient number
ALL       PTINIT   $8        Patient initials
DEMOG     CENTER   $3        Clinic number
DEMOG     DOB      8         Date of birth
DEMOG     SEX      $1        Sex (M or F)
DEMOG     RACE     $1        Race Code
MEDHIS    SEQNO    8         History Sequence Number
MEDHIS    MEDHISNO 8         Medical History Number
MEDHIS    MHDT     8         Date of medical history
PHYSEXAM  VISIT    8         Visit Number
PHYSEXAM  SEQNO    8         Exam Sequence Number
PHYSEXAM  PHDT     8         Physical exam. date
PHYSEXAM  WT       8         Weight
run;

proc print data=macro3.vardir;
run;
