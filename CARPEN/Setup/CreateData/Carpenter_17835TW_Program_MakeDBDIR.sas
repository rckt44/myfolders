* MakeDBDIR.sas
* Create the list of data sets and their key varieables;

data macro3.DBDir;
infile cards truncover;
input dsn $8. @10 Keyvar $30.;
Datalines;
DEMOG    SUBJECT
MEDHIS   SUBJECT MEDHISNO SEQNO
PHYSEXAM SUBJECT VISIT SEQNO
run;

proc print data=macro3.dbdir;
run;
