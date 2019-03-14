* Program 9.2.2d.sas
* Building a list of named macro variables based on 
* data set names using the SET routine;

%macro M_all_data(dsn=);
%local dsid i nobs;
%let dsid = %sysfunc(open(&dsn)); 
/*%do i = 1 %to %sysfunc(attrn(&dsid,nvars));*/
/*   %unquote(%nrstr(%let) %sysfunc(varname(&dsid,&i)))=;*/
/*%end;*/

%let nobs= %sysfunc(attrn(&dsid,nlobs)); 
%syscall set(dsid); 
%do i = 1 %to &nobs;
   %let rc=%sysfunc(fetchobs(&dsid,&i)); 
   %* Local process goes here;
   %put ****** Observation &i *********; 
   %put _local_;
%end;
%let dsid = %sysfunc(close(&dsid));
%mend m_all_data;

%m_all_data(dsn=sashelp.class)
