/* HERE WE ARE TRYING TO ADD MULTIPLE NUMERIC CONSTANT WHEN THE AGE DIFFERS/INCREMENTS */
/* SO ,THE OBJECTIVE IS TO ADD 1 FOR AGE 16,ADD 2 FOR AGE 15,ADD 3 FOR AGE 14,ADD 4 FOR AGE 13, */
/* ADD 5 FOR AGE 13,ADD 6 FOR AGE 12 etc. */
data have; 
set sashelp.class(keep=name age height);
run;

proc sort data=have;by name descending age;run;

proc transpose data=have out=NIRAJ  (DROP=_NAME_) PREFIX=AGE;
id age;
var height;
by name;
run;

PROC STDIZE DATA=NIRAJ REPONLY MISSING=0 out=PASA;RUN;


DATA CCC;
SET PASA;
ARRAY FINAL{*}_NUMERIC_;
ARRAY SEMI{6}_TEMPORARY_(1,2,3,4,5,6);
DO i= 1 to dim(FINAL);
FINAL{i}=FINAL{i}+SEMI{i};
END;
RUN;




libname kanchan '/folders/myfolders' ;
