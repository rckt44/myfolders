* Program9.7a
* Transferring information between remote and local sessions
* CAUTION: this code will not execute as written without a 
*          remote connection having already been established;

%macro RBuild(dsn=,reg=);

%syslput rindat = &dsn;
%syslput rinreg = &reg;
rsubmit;
   data buildbig;
      set &rindat(where=(region="&rinreg"));
      run;
   %nrstr(%sysrput bigbuild = done;)
endrsubmit;

%put NOTE: BUILDBIG status is: &bigbuild;
%mend rbuild;
%rbuild(dsn=sashelp.shoes,reg=Africa)
