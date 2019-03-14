* Program 5.2.3
* Testing the IN operator;

options minoperator;
option mindelimiter=' ';

%macro tryit(state=, v1=, v2=, v3=);
%if &state=&v1 or &state=&v2 or &state=&v3 %then  %put &=state is one of the list |&v1 &v2 &v3|;
%if &state # &v1 &v2 &v3 %then %put TRYIT &=state is in |&v1 &v2 &v3|; 
%mend tryit;
%tryit(state= AK, v1=WA, v2= AK, v3=CA)

%macro test(state=, list=);
%if %upcase(&state) # %upcase(&list) %then %put TEST &=state is in &=list; 
%let inlist = %eval(&state in &list);
%put &=inlist;
%mend test;

%test(state= AK, list= CA WA AK)

