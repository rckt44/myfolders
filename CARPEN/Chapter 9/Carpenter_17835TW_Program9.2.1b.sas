* Program 9.2.1b.sas
* Determining existence and scope of macro variables;

%macro symcheck(mscope,mvname);
   %* Determine if a specific macro variable 
   %* has been defined in a specific scope.;
   %local fetchrc dsnid rc;
   %let rc  = 0;
   %let dsnid  = %sysfunc(open(sashelp.vmacro  
                    (where=(scope=%upcase("&mscope") and 
                            name=%upcase("&mvname"))),i));
   %let fetchrc = %sysfunc(fetch(&dsnid,noset));  
   %if &fetchrc eq 0  %then %let rc=1;
   %let dsnid = %sysfunc(close(&dsnid)); 
   &rc
%mend symcheck;
%*put %symcheck(global,path);
%macro testit;
%if %symcheck(global,path) %then %put The macro variable PATH exists in the Global symbol table;
%mend testit;
%testit
