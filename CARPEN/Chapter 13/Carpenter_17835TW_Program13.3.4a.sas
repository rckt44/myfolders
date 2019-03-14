* Program 13.3.4a.sas
* Building a WHERE clause;

%macro makecsv(dsn=,list=,reg=,miss=,chkvar=wt,no=no);
options &no.mprint &no.mlogic &no.symbolgen;
%* LIST   one or more blank separated clinic numbers;
%*           Blank to get all clinics;
%* REG    Region of interest
%*           Blank to select all regions
%* MISS   are observations with missing weights allowed?
%*           ok       missing ok
%*           <other>  nonmissing only;

%local qlist wclause;  

%* Quote the words in the list and separate 
%* them with commas;
%let qlist = 
     %str(%')%sysfunc(tranwrd(&list,%str( ),%str(',')))%str(%');

 
%* Build the WHERE clause;
%if &miss=ok %then %let wclause = &chkvar ge ._;  
%else %let wclause = &chkvar gt .z;
%if &reg ne %then %let wclause = &wclause & region="&reg";  
%if %bquote(&list) ne  %then 
      %let wclause = &wclause & clinnum in(&qlist);  

data _null_;
   set &dsn(where=(%unquote(&wclause))); 
   file "c:\temp\makecsv.csv" dlm=',';
   if _n_=1 then put "clinicnumber,clinicname,region,&chkvar";
   put clinnum clinname region &chkvar;
   run;
%mend makecsv;
%makecsv(dsn   = macro3.clinics,
         list  = 051345 057312,
         reg   = 5, 
         miss  = ok,
         chkvar= death,
         no    = no)   
