* Program 14.3.6a.sas
* Symbol table assignments;

%let a = global_var;  

%macro tryit;
   %let at = var_local_to_tryit; 
   %inside
%mend tryit;

%macro inside;
   %let b=var_on_the_inside_table;  
   %put **All Current Vars;
   %put _user_;  
%mend inside;

%tryit
%put **** Open code Macro vars;
%put _user_;  

