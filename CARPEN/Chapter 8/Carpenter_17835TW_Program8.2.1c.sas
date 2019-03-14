* Program8.2.1c.sas
* Using %SYMDEL to delete macro variable lists;

%* delete all macro variables from the global symbol table;
proc sql noprint;
   select distinct NAME
      into :maclist separated by ' '
         from dictionary.macros
            where upcase(SCOPE) eq 'GLOBAL' 
                and NAME NE 'maclist'
/*                and name ne 'SYS_SQL_IP_ALL'*/
/*                and name ne 'SYS_SQL_IP_STMT'*/
;
   quit;
%put &=maclist;
%symdel &maclist maclist;
%put _global_;
%put _automatic_;
