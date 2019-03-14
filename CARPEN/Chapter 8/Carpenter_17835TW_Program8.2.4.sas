* Program 8.2.4
* Creating a directory with %SYSEXEC;

%macro makedir(newdir);
   %local rc;
  * Make sure that the directory exists;
  %let rc = %sysfunc(fileexist(&newdir));
  %if &rc=0 %then %do;
     %put Creating directory &newdir;
     %* Make the directory;
     %sysexec  md &newdir;
  %end;
  %else %put Directory &newdir already exists;
%mend makedir;

options noxwait;
%makedir(c:\tempzzz)
%put Return Code: &sysrc ;
%makedir(z:\tempzzz)
%put Return Code: &sysrc ;
