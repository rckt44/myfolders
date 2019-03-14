* Program 11.3.2.sas
* Using a list of data set names;
option symbolgen;
%macro listdsn;
%do i = 1 %to &dsncnt;
  %put &=i  &&dsn&i;
%end;
%mend listdsn;
%listdsn
