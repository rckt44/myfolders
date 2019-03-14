* Program 13.3.4b.sas
* Building a WHERE clause;

%macro findoutliers(dsn=,prefix=,value=,op=ge, logicop=or);
%local i wclause;
proc contents data=&dsn noprint
              out=contdsn;  
   run;

data _null_;
   set contdsn;
   if name =: %upcase("&prefix");
   cnt+1;
   call symputx(catt('var',cnt),trim(name),'l');  
   call symputx('varcnt',cnt,'l');  
   run;

%if varcnt ge 1 %then %do;
   %let wclause= &var1 &op &value;  
   %if varcnt gt 1 %then %do i = 2 %to &varcnt;
      %* Build the where clause; 
      %let wclause = &wclause &logicop &&var&i &op &value;
   %end;

data outliers;
   set &dsn(where=(&wclause));  
   run;
%end;
%mend findoutliers;
%findoutliers(dsn=macro3.biomass,prefix=bm, value=6, op=ge,logicop=or)
