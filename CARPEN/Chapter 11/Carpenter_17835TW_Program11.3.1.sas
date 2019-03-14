* Program 11.3.1.sas
* Use Control information to build a vertical list of macro variables;

proc sql noprint;
   select dsn
      into :dsn1 -
         from macro3.dbdir;
   %let dsncnt = &sqlobs;
   quit;
