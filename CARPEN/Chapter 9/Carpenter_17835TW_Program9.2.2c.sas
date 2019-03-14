* Program 9.2.2c.sas
* Building a list of named macro variables based on data set names;

%macro M_all_data(dsn=);
%local nobs;
data _null_;
   set &dsn;

   * Variable Arrays;
   array _nums {*} _numeric_;
   array _char {*} $ _character_;

   if dim(_nums) then do i = 1 to dim(_nums);
      call symputx(catt(vname(_nums{i}),_n_),_nums{i},'l');
   end;
   if dim(_char) then do i = 1 to dim(_char);
      call symputx(catt(vname(_char{i}),_n_),_char{i},'l');
   end;
run;
%let NObs = &sysnobs;

* Your process which utilizes these macro variables goes here;
%put _local_;

%mend m_all_data;

%m_all_data(dsn=sashelp.class)
