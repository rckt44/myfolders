* Program 7.4.2d.sas
* Using %SYSFUNC to delete a file;

%macro delfile(fname=);
  %local filrf rc;
   %let filrf=___fref;
  %if %sysfunc(fileexist(&fname)) %then %do;
     %* The file exists, establish the fileref;
     %let rc=%sysfunc(filename(filrf,&fname));
     %* Delete the file;
     %let rc=%sysfunc(fdelete(&filrf));
     %* Clear the fileref;
     %let rc=%sysfunc(filename(filrf));
  %end;
  %else %put File Not Found;
%mend delfile;

%delfile(fname=c:\temp\agefreq.xml)
