* Program9.6.sas
* Executing an equation stored in the data;

/* create sample data */

data have ;
format calc_exprsn $50.;
input input1 input2 input3 input4 calc_exprsn $ &;
datalines;
4 6 7 9  INPUT1 * INPUT2 + 100
8 8 6 2  INPUT3 / INPUT2
8 3 90 11  INPUT1 - INPUT3
run;

/* evaluate expression using sysevalf in a datastep */

data want;
length name $ 8;
set have ;
drop i name;
macro_exprsn = tranwrd(calc_exprsn, 'INPUT' , '&INPUT' );
array nums { * } input1-input4;
do i = 1 to dim(nums);
  call vname(nums{i}, name);
  call symputx(name, nums{i});
end;
calc_rslt = resolve('%sysevalf('||macro_exprsn||')');
calc_rslt2 = compbl(resolve(macro_exprsn));
run;
