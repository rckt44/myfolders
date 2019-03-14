* Program 8.1.2.sas
* Displaying the nesting structure of a series of nested macro calls;

%macro one;
   %put in one;
   %two
%mend one;
%macro two;
   %put in two;
   %three
%mend two;
%macro three;
   %put in three;
   %showmacnest
%mend three;
%macro ShowMacNest;
   %local i;
   %do i = 1 %to %sysmexecdepth;
      %put Level &i, Macro name is: %sysmexecname(&i);
   %end;
%mend showmacnest;
%put Level 0: %sysmexecname(0);
%one
