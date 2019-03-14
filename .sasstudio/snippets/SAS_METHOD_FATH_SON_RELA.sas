data ag;
input id age;
cards;
1 20
1 50
2 60
2 22
3 30
3 60
;
run;
data rela;
input id rel $;
cards;
1 mother
1 doughter
2 son
2 father
3 son
3 father
;
run;
/* step-1 */
proc sort data=ag;by id age;run;
proc sort data=rela;by id;run;
/* step-2 */
data age1;
set ag;
by id ;
if first.id then do;
flag="min";
end;
if last.id then do;
flag="max";
end;
run; 
/* step-3 */
data rela1;
set rela;
if rel in ("father","mother") then do;
flag="max";
end;
if rel in ("son","doughter") then do;
flag="min";
end;
/* step-4 */
proc sort data=rela1;by id flag;run;
proc sort data=age1;by id flag;run;
/* step-5 */
data final(keep=id age rel flag);
merge age1 rela1;
by id flag ;
run;




