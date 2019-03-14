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
/* sql method */
/* step-1 */
proc sql;
create table table1 as 
select t.* from 
(
select id,max(age)as a,case when max(age) then 1  end as flag
from ag
union 
select id,min(age) as a,case when min(age)then 0  end as flag
from ag
)
t;
/*group by id;/*this group by is optional*/
quit;
/* step-2 */
proc sql;
create table table2 as
select rela.*,
case when rel in ("mother","father") then 1 else 0 end as flag
from rela;
quit;
/* step-3 */
proc sql;
create table final as 
select table1.id ,table1.a, rel from table1,table2
where table1.id=table2.id and table1.flag=table2.flag;
quit;

/* sas method */




