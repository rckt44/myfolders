* Program 11.2.6a.sas
* Using functions to access the meta-data;

%macro obscnt(dsn); 
%local dsnid nobs;
%let nobs=.;

%* Open the data set of interest;
%let dsnid = %sysfunc(open(&dsn));  
%* If the open was successful get the;
%* number of observations and CLOSE &dsn;
%if &dsnid %then %do;  
     %let nobs=%sysfunc(attrn(&dsnid,nlobs));  
     %let dsnid  =%sysfunc(close(&dsnid)); 
%end;
%else %do; 
     %put Unable to open &dsn - %sysfunc(sysmsg());
%end;

%* Return the number of observations; 
&nobs 
%mend obscnt;

%put There are %obscnt(sashelp.shoes) observations in sashelp.shoes; 
%put There are %obscnt(sashelp.shss) observations in sashelp.shss; 
