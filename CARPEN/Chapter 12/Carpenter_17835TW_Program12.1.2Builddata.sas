* Program 12.1.2Builddata.sas
* Build some dummy data sets for use with Section 12.1.2;

%macro bld;
%local i;
%do i = 1 %to 5;
   data IN&i;
      From_DS = &i;
      set sashelp.class(obs=3);
      run;
%end;
%mend bld;
%bld

