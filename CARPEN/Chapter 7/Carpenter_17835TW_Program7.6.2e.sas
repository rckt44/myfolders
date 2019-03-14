* Program 7.6.2e.sas
* Compare two strings of unequal length;

%macro coloncmpr(left,op,right);
 %local width;

 %if &op = %str() %then %let op==; 

 %* determine shorter of left and right;
 %let width = %sysfunc(min(%length(&left),%length(&right)));
 %upcase(%qsubstr(&left,1,&width) &op %qsubstr(&right,1,&width))
%mend coloncmpr;

%macro tryit;
   %let a = Smith;
   %let b = sm;
   %if %coloncmpr(&a,=,&b) %then %put &a =: &b is true;
%mend tryit;
%tryit

