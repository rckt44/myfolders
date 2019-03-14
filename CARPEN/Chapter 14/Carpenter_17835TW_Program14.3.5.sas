* Program 14.3.5.sas
* An implied %EVAL.;

%macro test(xcode);
%let i=0;
%do %while((%scan(&xcode, &i+1))>%bquote());
   %let i = %eval(&i+1);
   %let word = %scan(&xcode, &i);
   %put &=i &=word;
%end;
%mend test;
%test(a b c dd eee)
