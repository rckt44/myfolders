* Program A1.7.4.sas
* Counting the words in a list;

%macro count(string,parm);
   %local count word;
   %if &parm= %then %let parm = %str( );
   %let count=0;
   %let word = %qscan(&string,&count+1,&parm);
   %do %while(&word ne);
      %let count = %eval(&count+1);
      %let word = %qscan(&string,&count+1,&parm);
   %end;
   &count
%mend count;
%put %count( );
%put %count(this is a short string);
%put %count(this is a short string, %str( ));
%put %count(%nrstr(this*&is*a*string),%str(*));
%put %count(%nrstr(this,&is,a,comma,separated,string),%bquote(,));

%* The COUNTW function can can have up to 3 arguments.
%* The second and third args should be optional.
%* When a comma follows the first argument (&STRING) 
%* a word delimiter must be supplied.
%* If no word delimiter is supplied allow default set of parameters;
%macro count2(string,parm);
   %if &parm ne %then %sysfunc(countw(&string,&parm));
   %else %sysfunc(countw(&string));
%mend count2;
%put %count2(this is a short string);
%put %count2(this is a short string, %str( ));
%put %count2(%nrstr(this*&is*a*string),%str(*));
%put %count2(%nrstr(this,&is,a,comma,separated,string),%bquote(,));
 
