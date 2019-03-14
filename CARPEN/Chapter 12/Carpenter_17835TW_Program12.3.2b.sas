* Program 12.3.2b.sas
* Build a format and check search path;

%macro mkfmt(lib=, dsn=, fmtname=, from=, too=);

   %* When the fmt name is unspecified,
   %* use the incoming var name (FROM) as the format name;
   %if &fmtname= %then %let fmtname=&from;  

   * Eliminate duplicate values of &from;
   proc sort data=&dsn(keep=&from &too)
             out=temp
             nodupkey;
      by &from;
      run;

   data control(keep=fmtname start label type); 
      set temp(rename=(&from=start &too=label));
      length type $1 fmtname $18;
      retain fmtname "&fmtname" type ' ';

      * Determine the format type;
      If _n_=1 then type = vtype(start);  
      run;

   proc format
         %if &lib ne %then library=&lib; 
         cntlin=control;
      run;

   %if &lib ne %then %fmtsrch(lib=&lib,add=x); 
%mend mkfmt;
%mkfmt(lib=work, dsn=sashelp.class, fmtname=, from=name, too=weight)
%mkfmt(lib=work, dsn=sashelp.class, fmtname=nm2sx, from=name, too=sex)
%mkfmt(lib=macro3,dsn=macro3.clinics,fmtname=clname,from=clinnum,too=clinname)

