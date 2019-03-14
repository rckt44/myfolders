* Program 13.2.2b.sas
* Determine if a directory exists and 
* create it using DCREATE if it does not;

%macro ChkDir2(DirLoc=, DirName=);
   %* if the directory does not exist, make it;
   %if %sysfunc(fileexist("&dirloc\&dirname"))=0 %then %do;
      %put Create the directory: "&dirloc\&dirname"; 
      %* Make the directory;
      %sysfunc(dcreate(&dirname,&dirloc))
   %end;
   %else %do;
      %put The directory "&dirloc\&dirname" already exists;
      &dirloc\&dirname
   %end;
%mend chkdir2;

* HTML destination;
ods html path="%chkdir2(dirloc=c:\temp,dirname=hazardratios)" 
         body="HRatioModel35.html";

proc print data=sashelp.class;
   run;
ods html close;
