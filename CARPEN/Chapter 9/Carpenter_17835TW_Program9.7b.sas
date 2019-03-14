* Program9.7b
* Transferring information between remote and local sessions
* CAUTION: this code will not execute as written without a 
*          remote connection having already been established;

%macro RBuild(dsn=,reg=);

%syslput _local_;
rsubmit;
   data buildbig;
      set &dsn(where=(region="&reg"));
      run;
   %sysrput bigbuild = done;
endrsubmit;

%put NOTE: BUILDBIG status is: &bigbuild;
%mend rbuild;
%rbuild(dsn=sashelp.shoes,reg=Africa)
