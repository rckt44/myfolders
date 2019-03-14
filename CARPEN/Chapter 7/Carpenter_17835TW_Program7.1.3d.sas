* Program 7.1.3d.sas
* Passing special characters into a macro;
data _null_;
   call symput('ttl',"Tom's Truck");
   run;

%macro pprintit(txt=); 
   title1 "&txt";
   title2 &txt;
   proc print data=sashelp.class;
   run;
%mend pprintit;

%* This macro call will fail;
%pprintit(txt=&ttl)
%* Quoting masks the single quote;
%pprintit(txt=%bquote(&ttl))

* Commas can cause similar problems;
%let lst = a, b, c;

* This macro call will fail;
%pprintit(txt=&lst)
%* Quoting masks the commas;
%pprintit(txt=%bquote(&lst))

