* Program 6.1a
* Conditional execution of a %LET;
data age;
   set sashelp.class(where=(name='Jane'));
   %let jane_age = age;
   run;
%put &=jane_age;
