data monname;
date = '14SEP2014'd;
do i=9, 10, 11, 15;
   fmt = cats('monname',put(i,2.),'.');
   value = putn(date,fmt);
   output;
end;
run;

ods _all_ close;
ods listing;
proc print data=monname NOOBS;
var fmt value;
run;
ods listing close;
