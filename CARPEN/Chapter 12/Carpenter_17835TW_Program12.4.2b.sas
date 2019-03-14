* Program 12.4.2b.sas
* Create a list of unknown variable names
* using DATA step functions;

%macro VList(dsn=, bylist=, id=, var=);
%global varlist;
*** create the transposed data set; 
proc sort data=&dsn(keep=&bylist &id &var)
          out=srtdata
          nodupkey;
   by &bylist &id;
   run;
proc transpose data=srtdata
               out=trnsdata;
   by &bylist;
   id &id;
   var &var;
   run;
 
* create a space-delimited variable list using a DATA step ;
data _null_;
   set trnsdata;
   array allc {*}_character_;  
   array alln {*}_numeric_; 
   length __name $32 __str $500; 
   if dim(allc) then do __i=1 to dim(allc);  
      call vname(allc{__i},__name);  
      * Exclude vars we know we do not want;
      if __name not in('_NAME_' '_LABEL_') then __str = catx(' ',__str,__name); 
   end;
   if dim(alln) then do __i=1 to dim(alln);
      call vname(alln{__i},__name);
      __str = catx(' ',__str,__name);
   end;
   call symputx('varlist',__str,'g'); 
   stop; 
   run;

%put &=varlist;
%mend VList;
%VList(dsn=sashelp.shoes, bylist=region subsidiary, id=product, var=sales)
