* Program 12.3.2a.sas
* Check the format search path;

%macro fmtsrch(lib=macro3,add=);
   %local optval insrch;
   %* Check to see if a libref is in the format search path
   %* lib   libref to check
   %* add   If &add is not null, then add the libref, if
   %*       it is not already in the fmtsearch value
   %*
   %* Macro actions:
   %* writes &INSRCH to the LOG
   %*    0  if &LIB is not on path
   %*    >0 if &LIB is on path
   %* &ADD is not null & &LIB is not in search path: 
   %*    OPTION statement is written to add &LIB to FMTSEARCH;

   %* Determine if the library is on the fmt search path;
   %let optval = %sysfunc(getoption(fmtsearch)); 
   %*put &=optval;
   %let insrch = %index(&optval,%upcase(&lib)); 
   %put &=insrch; 

   %if &insrch = 0 & &add ne %then %do; 
      %* Add &lib to format search, 
      %* Remove the trailing close parenthesis;
      %let optval =  
            %substr(&optval,1,%eval(%length(&optval)-1));
      %* Add the library;
      options fmtsearch=&optval &lib);   
   %end;
%mend fmtsrch;
%fmtsrch(lib=work,add=)
%put %sysfunc(getoption(fmtsearch));
%fmtsrch(lib=macro3,add=)
%put %sysfunc(getoption(fmtsearch));
%fmtsrch(lib=macro3,add=x)
%put %sysfunc(getoption(fmtsearch));
