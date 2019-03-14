* Program A1.6.4
* Convert all numeric variables to character.
* Preserve formatting. 
* Use formats in the conversion process;

%macro allchar(dsn=);
%local i;

* Determine the numeric vars in &dsn;
proc contents data=&dsn 
              out=cont(where=(type=1)
                       keep=name type format formatl formatd label) 
              noprint;
   run;

* Create the macro variables for each numeric var;
data _null_;;
   set cont end=eof;
   length fmt $15;

   * Count the numeric vars and save the total number;
   i+1;
   ii=left(put(i,3.));
   if eof then call symputx('n',ii,'l');

   * create a format string;
   fmt = 'best.';
   if format ne ' ' then fmt = catt(format,formatl,'.',formatd);
   call symputx('fmt'||ii,fmt,'l');

   * Save the variable name;
   call symputx('name'||ii,name);

   * Save the label for this variable;
   if label = ' ' then label = name;
   call symputx('label'||ii,label);
   run;

* Establish a data set with only character variables;
* &n       number of numeric variables in &dsn;
* __aa&i   temporary var to hold numeric values;
* &&name&i name of the variable to covert from numeric;
*
* The numeric value of &name1 is stored in __aa1
* by renaming the variable in the SET statement.  __aa1
* is then converted to character and stored in the
* 'new' variable &name1 in the data set CHARONLY.
* ;
data charonly (drop=
   %* Drop the temp. vars used to hold numeric values;
   %do i=1 %to &n;
      __aa&i
   %end;
    );
length
   %* Establish the vars as character;
   %do i=1 %to &n;
      &&name&i
   %end;
    $8;

set &dsn (rename=(
   %* Rename the incoming numeric var to a temp name;
   %* This allows the reuse of the variables name;
   %do i=1 %to &n;
      &&name&i=__aa&i
   %end;
   ));

   * Convert the numeric values to character;
   %do i=1 %to &n;
      &&name&i = left(put(__aa&i,&&fmt&i));
      label &&name&i = "&&label&i";
   %end;
run;

proc contents data=charonly;
proc print data=charonly;
run;
%mend allchar;

%allchar(dsn=macro3.biomass)
