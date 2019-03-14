* Program 12.4.4b.sas
* Using TRANWRD to replace spaces with commas;

%macro cstr(list);
   %* Return a list of words as a comma-separated list;
   %sysfunc(tranwrd(%cmpres(&list),%str( ),%str(,)))
%mend cstr;

options nomprint;
%put |%cstr(region)|;
%put |%cstr(region clinnum)|;
%put |%cstr(region.clinnum/sex   edu)|;
