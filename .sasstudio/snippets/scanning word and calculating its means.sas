/* this question was taken from sas communites,you can search there for more details */

data have;
informat name $80.;
  input name &;
  cards;
John If_True kary
John If_True Mary
John If_True kary
John If_True kary
Tom If_Not Carol
Tom If_Not Carol
Tom If_Not Carol
Joe If_True Jane
Joe If_False Jane
Joe If_False Paul
Joe If_False Jane
Paul If_False Jane
Joe If_False Jane
Joe If_False Jane
;


/* PARTIAL MATCHING OF TEXT,AND ON THAT BASIS FINDING THEIR MEANS */

/* LIKE IN SAS SAS STEP,YOU WOULD DO; */
DATA A;
SET have;
if find (name,'If_True')>0 and index(Name,'kary')>0 then do;
n1=1;
end;
if find (name,'If_False')>0 and index(Name,'Paul')>0 then do;
n2=1;
end;
run;

proc means data=a;
var n1 n2;
run;


/* the alternative proc sql step would be below */





proc SQL;
SELECT
sum(case when find (name,'If_True')>0 and index(Name,'kary')>0 then 1 else 0 end) into: N1 FROM have;
SELECT
sum(case when find (name,'If_False')>0  and index(Name,'Paul')>0 then 1 else 0 end) into: N2 FROM have;
quit;

%put &n1;
%put &n2;