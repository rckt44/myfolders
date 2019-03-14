* Program 7.6.2d.sas
* Repeat a list of characters;

%macro repeat(char,times);
  %let char = %quote(&char);
  %if &char eq %then %let char = %str( );
  %sysfunc(repeat(&char,&times-1))
%mend;

%put %repeat(abc,3) ;
