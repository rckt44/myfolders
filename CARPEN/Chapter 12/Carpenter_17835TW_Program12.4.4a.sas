* Program 12.4.4a.sas
* Building a comma separated list;

%macro cstr(list);
   %* Return a list of words as a comma-separated list;
   %local clist count;
   %let count=0;
   %do %while(%qscan(&list,&count+1) ne %str() );
      %let count = %eval(&count+1);
      %if &count=1 %then %let clist = %qscan(&list,&count);
      %else %let clist =&clist,%qscan(&list,&count); 
   %end;
   &clist
%mend cstr;

options nomprint;
%put |%cstr(region)|;
%put |%cstr(region clinnum)|;
%put |%cstr(region.clinnum/sex   edu)|;
