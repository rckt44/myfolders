* Program 12.4.5c.sas
* Quoting words in SQL;
%macro qCharVar(lib=,dsn=);
   %local qlist;
   proc sql noprint;
   select quote(trim(name))
      into :qlist separated by ","
         from dictionary.columns
            where libname="%upcase(&lib)"  
                & memname="%upcase(&dsn)" 
                & type='char';
   quit;
   %* Usage of the quoted list would go here.;
   %put |&qlist|;
%mend qcharvar;
options nomprint;
%qcharvar(lib=macro3, dsn=clinics)
