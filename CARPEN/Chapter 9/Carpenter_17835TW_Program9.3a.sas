* Program9.3a.sas
* Forming a simple hash;
* Single index and a known list of variables;

data _null_;
   set sashelp.class;
   call symputx(name,catx('|', age, sex, height, weight));
   run;

%put &=alice;
%let alice_wt = %scan(&alice,4,%str(|));
%put &=alice_wt;

data student_ht;
input student $;
if symexist(student) then height = scan(symget(student),3,'|');
else height=' ';
datalines;
alice
fred
barbara
run;
proc print data=student_ht;
   run;
