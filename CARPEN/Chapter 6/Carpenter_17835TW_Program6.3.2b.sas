* Program 6.3.2b 
* Resolving macro variables before compilation of the DATA step;
%let adj1 = 1.1;
%let adj2 = 2.4;
%let adj3 = 3.1;

data clinics;
   set macro3.clinics(keep=wt);
   code = ceil(ranuni(0)*3);
   run;

data adjwt;
   set clinics;
   if code=1 then wtadj = wt*&adj1;
   else if code=2 then wtadj = wt*&adj2;
   else if code=3 then wtadj = wt*&adj3;
   run;

* Simplify code using SYMGET;
data adjwt;
   set clinics;
   wtadj = wt*symget(catt('adj',code));
   run;

* Using the INPUT to convert from character to numeric;
data adjwt;
   set clinics;
   wtadj = wt*input(symget(catt('adj',code)),best12.);
   run;

* Using SYMGETN to convert from character to numeric;
data adjwt;
   set clinics;
   wtadj = wt*symgetn(catt('adj',code));
   run;
