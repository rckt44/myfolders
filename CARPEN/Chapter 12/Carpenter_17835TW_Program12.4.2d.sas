* Program 12.4.2d.sas
* Create a list of unknown variable names
* using a macro function;

%Macro GetVars(Dset) ;
   %Local VarList ;
   /* open dataset */
   %Let FID = %SysFunc(Open(&Dset)) ; 
   /* If accessable, process contents of dataset */
   %If &FID %Then %Do ;
      %Do I=1 %To %SysFunc(ATTRN(&FID,NVARS)) ;  
        %Let VarList=&VarList %SysFunc(VarName(&FID,&I)); 
      %End ;
      /* Close dataset when complete */
      %Let FID = %SysFunc(Close(&FID)) ;  
   %End ;
   &VarList 
%Mend ;

%macro VList(dsn=, bylist=, id=, var=);
%global varlist;
*** create the transposed data set; 
proc sort data=&dsn(keep=&bylist &id &var)
          out=srtdata
          nodupkey;
   by &bylist &id;
   run;
proc transpose data=srtdata
               out=trnsdata(drop=_name_ _label_);
   by &bylist;
   id &id;
   var &var;
   run;
 
%let varlist=%getvars(trnsdata);

%put &=varlist;
%mend VList;

%let varlist=;
%VList(dsn=sashelp.shoes, bylist=region subsidiary, id=product, var=sales)
