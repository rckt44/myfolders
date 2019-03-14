data have;
set sasuser.y2000;run;
data have; set sashelp.class(keep=name age height);run;

proc sort data=have;by name;run;

proc transpose data=have out=NIRAJ  (DROP=_NAME_) PREFIX=AGE;
id age;
var height;
by name;
run;

PROC STDIZE DATA=NIRAJ REPONLY MISSING=0;RUN;


DATA CCC;
SET PASA;
ARRAY FINAL{*}_NUMERIC_;
ARRAY SEMI{6}_TEMPORARY_(1,2,3,4,5,6);
DO i= 1 to dim(FINAL);
FINAL{i}=FINAL{i}+SEMI{i};
END;
RUN;
