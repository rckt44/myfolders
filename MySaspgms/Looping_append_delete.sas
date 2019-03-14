%macro tenit;
%do i=1 %to 10;
data get_&i;
length b $ 10.;
a=&i;
b="to test"||left("&i");
run;
proc append base=fnl data=get_&i force;run;
proc delete data=get_&i;run;
%end;
%mend;
%tenit;


