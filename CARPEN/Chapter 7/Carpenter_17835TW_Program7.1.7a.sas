* Program 7.1.7a.sas
* Using %SUPERQ;

data _null_;
   call symputx('hascall', 'NOTE: Call macro %doit');
   call symputx('call2', 'NOTE: Call macro %doit');
   run;

%put &hascall;
%put %superq(hascall);
 
%* This call causes an error;
%put %superq(&hascall);

%let callname = hascall;
%* &&&callname resolves to &hascall;
%* &callname resolves to hascall;
%put %superq(&callname);

%let i=2;
%put %superq(call&i);
%let hold2 = hascall;
%put %superq(hold&i);
%put %superq(&&hold&i);
