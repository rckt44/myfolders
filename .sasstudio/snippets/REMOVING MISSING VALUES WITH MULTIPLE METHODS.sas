DATA A;SET SASHELP.CLASS;RUN;
DATA B;SET A(RENAME=(HEIGHT=SALARY));
KEEP NAME AGE SALARY;
RUN;
PROC SORT DATA=B;BY NAME;RUN;

PROC TRANSPOSE DATA=B OUT=C (DROP=;
ID AGE;
BY NAME;
VAR SALARY;
RUN ;




data have;
set sasuser.y2000;run;
data have; set sashelp.class(keep=name age height);run;

proc sort data=have;by name;run;



proc transpose data=have out=need(drop=_name_) prefix=age;
id age;
var height;
by name;
run;
proc print data=need replace;
run;

data wish;
set need;
array rvmiss{*}_numeric_;

do _n_=1 to dim(rvmiss);

if  missing (rvmiss{_n_})  then rvmiss{_n_}=0;

end;
run;




proc stdize data=need reponly missing=0 ;
run;



data wish;
set need;
if missing(age14) then age14=111;
if not missing(name) then name="kkk";
run;



data wish;
set need;
array mm{*}_numeric_;
/* do _n_=1 to dim(mm); */
do over mm ;
mm(_n_)=coalesce(mm(_n_),'0');
end;
run;


/* data wish;set need; */
/* array mi{*}_numeric_; */
/* if mi{*} eq " " then  */

proc stdize data=need  reponly missing=11;
run;




