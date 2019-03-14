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
proc sort data=ag;by id age;run;
proc sort data=rela;by id;run;

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

data rela1;
set rela;
if rel in ("father","mother") then do;
flag1="max";
end;
if rel in ("son","doughter") then do;
flag1="min";
end;

proc sql;
select age1.id ,age1.age, rel from age1,rela1
where age1.id=rela1.id and age1.flag=rela1.flag1;
quit;


