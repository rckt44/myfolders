* Program 7.3.2a.sas
* Using the %EVAL function;

%macro chkwt(wt1, wt2);
   %if &wt1 > &wt2 %then %let note = heavier;
   %else %let note = lighter;
   %put First weight is &note.  &wt1 &wt2;
%mend chkwt;

%chkwt(1,2)
%chkwt(10,9)
%chkwt(2.1,2.2)
%chkwt(10.0,9.0)
