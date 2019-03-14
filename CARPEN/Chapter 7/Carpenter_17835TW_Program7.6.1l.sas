* Program 7.6.1l.sas
* Retrieving the last word in a list of words using %SCAN;

%macro listlast(list);
   %scan(&list,-1,%str( ))
%mend listlast;

%put %listlast(a b c d);

%* The B modifier could be used instead of  
%* a negative word number;
%macro listlast(list);
   %scan(&list,1,%str( ),b)
%mend listlast;

%put %listlast(a b c d);
