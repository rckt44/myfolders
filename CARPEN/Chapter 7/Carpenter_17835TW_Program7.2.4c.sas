* Program 7.2.4c.sas
* Trailing blanks and the %SUBSTR and %QSUBSTR functions;

data _null_;
   name='Joe      ';
   call symput('name',name);
   run;
%let sub = %substr(&name,1,4);
%put |&sub|;
%let qsub = %qsubstr(&name,1,4);
%put |&qsub|;
%let bqsub = %qsubstr(%bquote(&name),1,4);
%put |&bqsub|;

