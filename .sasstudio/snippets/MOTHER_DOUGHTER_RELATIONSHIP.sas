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
proc sql;
select t.* from 
(
select id,max(age),case when max(age) then 1  end as flag
from ag
union 
select id,min(age),case when min(age)then 0  end as flag
from ag
)
t
group by id;
quit;



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







