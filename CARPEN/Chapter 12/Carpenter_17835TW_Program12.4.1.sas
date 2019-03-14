* Program 12.4.1.sas
* Split a data set vertically;

%macro split(dsn=, dsnroot=fred, splitcnt=3);
%local dsid vcnt i cnteach j;
/*proc contents data=&dsn */
/*              out=vlist(keep=name) */
/*              noprint;*/
/*   run;*/
/**/
/*proc sql noprint;*/
/*   select name */
/*      into :vars1 -*/
/*         from vlist;*/
/*   %let vcnt = &sqlobs;*/
/*   quit;*/
%let dsid = %sysfunc(open(&dsn));
%if &dsid ne 0 %then %do;
   %let vcnt = %sysfunc(attrn(&dsid,nvar));
   %do i = 1 %to &vcnt;
      %local vars&i;
      %let vars&i = %sysfunc(varname(&dsid,&i));
      %*put &&vars&i; %* Debbugging;
   %end;
   %let dsid = %sysfunc(close(&dsid));

   %* Nominal number of variables in each new dataset;
   %let cnteach = %sysevalf(&vcnt/&splitcnt,ceil);

   data
      %do i = 1 %to &splitcnt;
         &dsnroot&i(keep=
            %do j= %eval((&i-1)*&cnteach+1) %to %sysfunc(min(&vcnt,%eval(&i*&cnteach)));
              &&vars&j
              %*put &=i &=j &&vars&j; %* Debugging;
            %end;
                   )
      %end;
      ;
      set &dsn;
      run;
%end;
%mend split;
*options mprint;
%split(dsn=sashelp.shoes, dsnroot=wanted, splitcnt=3)
%split(dsn=macro3.clinics, dsnroot=clinvert, splitcnt=4)



