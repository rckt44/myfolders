* Program 7.6.1m.sas
* Creating an %INDEXW function;

%macro indexw(list,wrd);
   %sysfunc(indexw(&list,&wrd))
%mend indexw;

%let mylist=concatinated catalonia cat;
%let myword=cat;
%put &myword is at position %indexw(&mylist,&myword);

%let mylist = aa bb cc a bb c;
%put the position is %indexw(&mylist,a);
