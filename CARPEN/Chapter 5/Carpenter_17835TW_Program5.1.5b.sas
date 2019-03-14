* Program 5.1.5b
* Nesting macro calls but not definitions;

%macro abc;
   ...code not shown...
   %def
%mend abc    ;    
%macro def;
   ...code not shown...
%mend def;
%abc

