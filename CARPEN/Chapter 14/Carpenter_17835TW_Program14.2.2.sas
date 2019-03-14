* Program 14.2.2.sas
* Storing an entire table in a matrix of macro variables.;

%macro buildmatrix(dsn=);
data _null_;
   set &dsn end=eof;
   array vlist {*} _numeric_; 
   length name $18;
   i+1;
   if eof then call symputx('rowcnt',i,'l');
   if i=1 then call symputx('colcnt',dim(vlist),'l');

   *** Store values for this row;
   * Build the base for the macro vars for this row;
   mbase = catt('r',i,'c'); 

   * Step through the values for this observation;
   do j = 1 to dim(vlist);
      * Save the value for this row and column;
      call symputx(catt(mbase,j),vlist{j},'l');

      * Save the variable name;
      if i=1 then do;
         call vname(vlist(j),name); 
         call symputx(catt('vname',j),name,'l');
   	end;
   end;
   run;

%* Show one element of the matrix;
%let rr = 4;
%let cc = 3;
%put Row &rr and col &cc (&&vname&cc) is %left(&&r&rr.c&cc); 

%dbval(maxrow=&rowcnt,maxcol=&colcnt)

%mend buildmatrix;
%macro dbval(maxrow=,maxcol=);
   %put row  col  Variable  value;
   %do row = 1 %to &maxrow;
      %do col = 1 %to &maxcol;
         %put &row    &col   &&vname&col   &&r&row.c&col;
      %end;
   %end;
%mend dbval;

%buildmatrix(dsn=sashelp.class)
