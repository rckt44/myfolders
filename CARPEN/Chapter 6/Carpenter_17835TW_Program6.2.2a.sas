* Program 6.2.2a
* Storing a list in a macro variable;
proc sql noprint;
  select name 
    into :namelist separated by' '
      from sashelp.class;
  quit;
%put Names are: &namelist;

