
libname klib '/folders/myfolders/kdata';

data both;
set klib.have klib.have2;
run;