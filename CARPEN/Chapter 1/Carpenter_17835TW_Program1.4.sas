* Carpenter_17835TW_Program 1.4.sas;
* Demonstrating th Inability to use %LET in the DATA Steps;
data _null_;
   set sashelp.class(keep=name age
                     where=(name='Jane'));
   %let j_age = age;
   run;

