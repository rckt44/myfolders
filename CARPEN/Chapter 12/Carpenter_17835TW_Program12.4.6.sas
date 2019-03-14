* Program 12.4.7.sas
* Create a list of distinct values;

%macro DistinctList(list);
   %local dlist i;
   %* Select the first word;
   %let dlist = %scan(&list,1,%str( ));    
   %let i=2;  
   %do %while(%scan(&list,&i,%str( )) ne %str());   
      %* There is another word. 
      %* Has it already been selected?;
      %if %sysfunc(indexw(&dlist,%scan(&list,&i,%str( ))))=0 %then %do;
         %* First occurence of this word add it to the list;
         %let dlist = &dlist %scan(&list,&i,%str( )); 
      %end;
      %* Increment counter to get the next word;
      %let i = %eval(&i+1);   
   %end;
   &dlist 
%mend distinctlist;     

%put %distinctlist(a b c aa bb cc);
%put %distinctlist(name name sex sex height height);
