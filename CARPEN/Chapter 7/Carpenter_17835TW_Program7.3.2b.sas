* Program 7.3.2b.sas
* Understanding the implied %EVAL;

%macro tryit;
%if 5  %then %put is 5;
%if %eval(6) %then %put is 6;
%*if 7. %then %put is 7.;
%*if %eval(8.) %then %put is 8.;
%if %eval(9.=9.) %then %put is 9.;
%if 10.=10. %then %put is 10.;
%mend tryit;
%tryit 

