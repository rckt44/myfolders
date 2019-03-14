* Program 9.2.1a.sas
* Determining existence and scope of macro variables;

%let inglobal = abc;
%macro test;
   %let inlocal = def;
   %let lvar = inlocal;
   %if %symexist(notavar)=0 %then %put NOTAVAR does not exist;
   %if %symglobl(inglobal) %then %put INGLOBAL in global;
   %if %symlocal(inlocal) %then %put INLOCAL in local;
   %if %symlocal(&lvar) %then %put INLOCAL in local (using LVAR);
   %if %symglobl(inlocal)=0 %then %put INLOCAL does not exist in global;
   %inner
   %if %symlocal(inner)=0 %then %put INNER is not local;
   %if %symexist(inner)=0 %then %put INNER does not exist;
%mend test;
%macro inner;
   %let inner=in_inner;
   %if %symlocal(inlocal) %then %put INLOCAL in INNER;
%mend inner;
%test
