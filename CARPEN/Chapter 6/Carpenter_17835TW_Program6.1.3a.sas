* Program 6.1.3a
* Retrieving in the same step using an &;
%symdel jane_age;
data age;
   set sashelp.class(where=(name='Jane'));
   call symputx('jane_age',age);
   j_age = &jane_age;
   run;
