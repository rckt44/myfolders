* Program 11.4.4a.sas
* Count the words in a horizontal list of values;

%macro wordcount(list);
   %* Count the number of words in &LIST;
   %local count;
   %let count=0;
   %do %while(%qscan(&list,&count+1,%str( )) ne %str());
      %let count = %eval(&count+1);  
   %end;
   &count  
%mend wordcount;

%let vars = name sex age weight height;
%put The number of words in |&vars| is %wordcount(&vars);
