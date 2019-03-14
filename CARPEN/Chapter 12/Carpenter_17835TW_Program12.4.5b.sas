* Program 12.4.5b.sas
* Using TRANWRD to replace spaces with comma separated quoted words;

%macro qstr(list);
   %* Return a list of words as a quoted and comma-separated list;
   %str(%')%qsysfunc(tranwrd(%cmpres(&list),%str( ),%str(%' ,%')))%str(%')
%mend qstr;

options nomprint;
%put |%qstr(region)|;
%put |%qstr(region clinnum)|;
%put |%qstr(region.clinnum/sex   edu)|;
