* Program 13.2.2a.sas
* Determine if a directory exists and create it if it does not;

%macro ChkDir(DirLoc=, DirName=);
   %* if the directory does not exist, make it;
   %if %sysfunc(fileexist("&dirloc\&dirname"))=0 %then %do;
      %put Create the directory: "&dirloc\&dirname"; 
      %* Make the directory;
      %sysexec md "&dirloc\&dirname";
   %end;
   %else %put The directory "&dirloc\&dirname" already exists;
   &dirloc\&dirname
%mend chkdir;

filename HRLoc "%chkdir(dirloc=c:\temp,dirname=hazardratios)\HRatioModel35.pdf";



************************************************************
* Note on composite filerefs;
* This works;
filename hrloc "c:\temp\hazardratios\HRatioModel35.pdf";
ods pdf file=hrloc;
* this works for an %include;
filename hrloc "c:\temp\hazardratios";
%inc hrloc(abc.sas);

* This does not work on the ODS statement;
filename hrloc "c:\temp\hazardratios";
ods pdf file=hrloc(HRatioModel35.pdf);


ods pdf close;

* This works for the HTML destination;
ods html path="%chkdir(dirloc=c:\temp,dirname=hazardratios)" 
         body="HRatioModel35.html";

proc print data=sashelp.class;run;
ods html close;
