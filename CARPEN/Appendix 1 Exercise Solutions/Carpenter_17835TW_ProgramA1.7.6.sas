* Program A1.7.6.sas
* Return the word number for the last 
* occurance of a word from a list of words;


%* The check on &WNUM=0 causes us to exit the loop after the 
%* first occurrence.  Removing the check allows the macro
%* to return the last occurrence;
%macro revscan(list, word);
   %local wcnt wnum;
   %let wcnt=0;
   %let wnum=0;
   %* Determine the word number in a list of words;
   %do %while(%scan(&list,%eval(&wcnt+1),%str( )) ne %str() /*& &wnum=0*/);
      %let wcnt = %eval(&wcnt+1);
      %if %upcase(%scan(&list,&wcnt,%str( )))=%upcase(&word) %then
         %let wnum=&wcnt;
   %end;
   &wnum
%mend revscan;

%let dosecode = a1 b1 b2 c b2; 

%* qb2 is not found and returns a 0;
%put qb2 %revscan(&dosecode,qb2);

%* b2 is the third and fifth word in &DOSECODE and a 5 is returned;
%put b2 %revscan(&dosecode,b2);
