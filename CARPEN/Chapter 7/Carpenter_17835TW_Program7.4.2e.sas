* Program 7.4.2e.sas
* Using %SYSFUNC to delete a file;

%macro delfile(fname=);
   %local filrf rc;
   %let filrf=___fref;
   %* Establish the fileref;
   %let rc=%sysfunc(filename(filrf,&fname));
   %* Delete the file if it exists;
   %if &rc = 0 and %sysfunc(fexist(&filrf)) %then 
         %let rc=%sysfunc(fdelete(&filrf));
   %else %put File Not Found;

   %* Clear the fileref;
   %let rc=%sysfunc(filename(filrf));
%mend delfile;

%delfile(fname=c:\temp\agefreq.xml)
