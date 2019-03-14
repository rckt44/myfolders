* Program 14.3.6f.sas
* A lost parentheses debugging problem;
 
%macro wrdcnt(string);
%let cnt=0;
%do %while(%scan(&string,&cnt+1,%str( )) ne %str());
   %let cnt = %eval(&cnt+1);
%end;
&cnt
%mend wrdcnt;
 
%put The count is %wrdcnt(the quick brown fox);
