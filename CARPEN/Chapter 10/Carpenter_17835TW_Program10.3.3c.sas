* Program 10.3.3c.sas
* Overwriting source code;

%macro aerpt(dsn, stdate, aelist) /store source ;
   %put testing AERPT;
%mend aerpt;


%macro chksrccopy(macname=, srcchk=, action=error, age=_);
%************
%* macname  name of the macro whose source code is to be retrieved
%* srcchk   path to the file to be checked prior to the copy
%* action   resultant action if the file exists
%*          error    copy is terminated with an error
%*                   This is the default
%*          warning  copy proceeds with a warning
%*                   the previous file is deleted.
%*          saveold  previous version is saved use AGE character
%* age      aging character appended onto the previous file - no checking done
%************;
%local xwait;
%let xwait = %sysfunc(getoption(xwait));
%* set xwait to noxwait;
options noxwait;

%if %sysfunc(fileexist(&srcchk)) %then %do;
   %* The file exists. Take appropriate action;
   %if %upcase(&action) = WARNING %then %do;
      %sysexec del &srcchk;
      %put WARNING: The file |&srcchk| was deleted prior to source retrieval;
   %end;
   %else %if %upcase(&action) = SAVEOLD %then %do;
      %sysexec copy &srcchk &srcchk.&age;
      %put NOTE: The file |&srcchk| was aged to |&srcchk.&age| prior to source retrieval;
   %end;
   %else %do;
      %put ERROR: The file |&srcchk| already exists - source generation terminated;
      %return;
   %end;
   %* retrieve source; 
   %copy &macname / out="&srcchk" source;
%end;

%* Restore xwait system option;
options &xwait;
%mend chksrccopy;
%chksrccopy(macname=aerpt, srcchk=c:\temp\aerpt2.sas)
%chksrccopy(macname=aerpt, srcchk=c:\temp\aerpt2.sas, action=warning)
%chksrccopy(macname=aerpt, srcchk=c:\temp\aerpt2.sas, action=saveold, age=_)
