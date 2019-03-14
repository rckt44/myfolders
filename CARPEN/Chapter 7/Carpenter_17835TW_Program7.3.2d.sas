* Program 7.3.2d.sas
* Implied use of the %EVAL function in %QSCAN;

%macro wordcnt(string=);
%local string wcnt;
%* The word count is stored in wcnt;
%let wcnt=0;
%do %until(%qscan(&string,&wcnt+1,%str( ))=%str());
   %let wcnt=%eval(&wcnt+1);
%end;
&wcnt
%mend wordcnt;

%* example:;
%put count is %wordcnt(string=aa bb cc);
