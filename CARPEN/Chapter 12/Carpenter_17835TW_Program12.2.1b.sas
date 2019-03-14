* Program 12.2.1b.sas
* Determine the next available title using a DATA step;

%macro printit;
%local i t u v ttl9 ttl10;
data _null_;
   set sashelp.vtitle(keep=type number text
                      where=(type='T')) end=eof;
   if number gt 8 then call symputx(catt('ttl',number),text,'l');
   if eof then do;
      call symputx('t',left(put(number,2.)),'l');
   end;
   run;

%*put &=t;
%if &t > 8 %then %let u=9; 
%else %let u = %eval(&t + 1);
%let v=%eval(&u+1);


title&u 'First custom title';
title&v 'Second custom title';
proc print data=sashelp.class(obs=3);
run;
title&u;
%if &t>8 %then %do i=9 %to &t;
   title&i &&ttl&i;
%end; 
%mend printit;
title1 'test of custom titles';
/*title9 'my title9';*/
/*title10 'my title10';*/
%printit
proc print data=sashelp.vtitle;
run;

