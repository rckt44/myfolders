* Program 4.4.3
* Using keyword parameters when calling
* a macro with positional parameters;

%macro test(start,stop);
   %put &=start;
   %put &=stop;
%mend test;
%test(start=aa, stop=bb)
%test(stop=bb, start=aa)

