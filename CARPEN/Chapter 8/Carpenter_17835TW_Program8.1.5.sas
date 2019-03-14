* Program 8.1.5
* Determining scope of a macro variable;

%macro symchkup(mvar);
   %local ___rc;
   %let ___rc = %eval( %symglobl(&mvar)
                  + %symlocal(&mvar)*2);
   &___rc
%mend symchkup;
%put DNE has a rc of %symchkup(DNE);
%let silly=global;
%put SILLY has a rc of %symchkup(silly);

%macro test;
   %local test;
   %put local test has a rc of %symchkup(test);
%mend test;
%put test has a rc of %symchkup(test);
%test

%macro test2;
   %local silly;
   %put local silly has a rc of %symchkup(silly);
%mend test2;
%test2
