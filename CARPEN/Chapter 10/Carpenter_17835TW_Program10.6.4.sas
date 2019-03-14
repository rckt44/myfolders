* Program 10.6.4
* Current and Early version of the %LOWCASE macro function;

%* Current version;
%macro lowcase(string);
%sysfunc(lowcase(%nrbquote(&string)))
%mend;

%* Early Version;
%macro lowcase(string);
%local i length c index result;
%let length = %length(&string);
%do i = 1 %to &length;
   %let c = %substr(&string,&i,1); 
   %if &c eq %then %let c = %str( );
   %else %do;
      %let index = %index(ABCDEFGHIJKLMNOPQRSTUVWXYZ,&c);  
      %if &index gt 0 %then  
           %let c = %substr(abcdefghijklmnopqrstuvwxyz,&index,1);  
      %end;
   %let result = &result.&c;  
   %end;
&result 
%mend; 

%put %lowcase(ASDFASDF);




