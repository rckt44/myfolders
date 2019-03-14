* Program 12.4.2a.sas
* Create a list of unknown variable names;

%macro VList(dsn=, bylist=, id=, var=);
%global varlist;
*** create the transposed data set; 
proc sort data=&dsn(keep=&bylist &id &var)
          out=srtdata
          nodupkey;
   by &bylist &id;
   run;
proc transpose data=srtdata
               out=trnsdata
/*               prefix=type_*/
      ;
   by &bylist;
   id &id;
   var &var;
   run;
 
* create a space-delimited variable list using a DATA step ;
data _null_ ;  
set sashelp.vcolumn(where=(libname='WORK' & 
                           memname='TRNSDATA' & 
                           name not in:('_NAME_' '_LABEL_'))) 
    end=eof ;
   file 'c:\temp\temp.sas' lrecl=70 ;
   if _n_=1 then put '%let varlist= ' @ ;  
   put name @ ;
   if eof then put ';' ;
   run ;

%include 'c:\temp\temp.sas' / source2 ; 
%put &=varlist;
%mend VList;
%VList(dsn=sashelp.shoes, bylist=region subsidiary, id=product, var=sales)
