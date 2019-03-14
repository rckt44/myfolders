* Program 12.3.1.sas
* Storing option settings for later recovery;

%macro storeopt(oplist);
%local tem;
%if &oplist ne %then %do;
   %let oplist = %cmpres(&oplist);
 
   %* Quote each option name individually;
   %let tem = %sysfunc(quote(&oplist)); 
   %let tem = %qsysfunc(tranwrd(&tem,%str( ),%bquote(",")));
   %*put &=tem;

   * Retrieve the current option settings;
   data _null_;
      set sashelp.voption;
      if optname in: (%upcase(&tem)) then do;  
         call symputx(optname,setting,'g');
      end;
      run;
%end;
%mend storeopt;
 
%storeopt(linesize pagesize obs   mlogic date) 
%put &=mlogic &=date &=obs;
