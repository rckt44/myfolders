* Program 12.4.5a.sas
* Building a quoted and comma separated list;

%macro qstr(list);
   %* Return a list of quoted and comma separated words;
   %local qlist count;
   %let count=0;
   %do %while(%qscan(&list,&count+1) ne %str() );
      %let count = %eval(&count+1);
      %if &count=1 %then %let qlist = %str(%')%qscan(&list,&count);
      %else %let qlist = &qlist%str(%',%')%qscan(&list,&count); 
   %end;
   &qlist%str(%') 
%mend qstr;

options  nomprint;
%put |%qstr(region)|;
%put |%qstr(region clinnum)|;
%put |%qstr(region.clinnum/sex   edu)|;
