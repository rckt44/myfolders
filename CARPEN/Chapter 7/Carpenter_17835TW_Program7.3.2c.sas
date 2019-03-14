* Program 7.3.2c.sas
* Implied use of the %EVAL function;

%macro try;
%let x=2;
%do i = &x+5 %to &x+10 %by &x;
   %put &=i;
%end;
%mend try;
%try
