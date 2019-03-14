* Program 5.1.5a
* Nesting macro definitions;

%macro abc;
      ...code not shown...

      %macro def;
         ...code not shown...
      %mend def;
      %def   

      ...code not shown...
%mend abc    ;
%abc

