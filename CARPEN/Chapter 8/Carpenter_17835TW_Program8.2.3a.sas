* Program 8.2.3a.sas
* Using %WINDOW to prompt for a data set name;

%macro dsnprompt(lib=sasuser);
%* prompt user to for data set name;
%window verdsn color=white 
  #2 @5 "Specify the data set of interest" 
  #3 @5 "for the library &lib" 
  #4 @5 'Enter Name: '
         dsn 20 attr=underline required=yes;

%display verdsn;

title1 "8.2.3a Print the &lib..&dsn data set"; 
proc print data=&lib..&dsn;
run;
%mend dsnprompt;

%dsnprompt(lib=macro3)
