/* get num of age by sex */
proc freq data=sashelp.class;
tables  age*sex / nopercent nocum;
run;
/* get number/frequency of age by sex */
proc freq data=sashelp.class ;
tables age*sex /  list missing nocum nopercent nocol norow;
run;
/* get cumilative sum too */
proc freq data=sashelp.class ;
tables age*sex /  list missing  nopercent nocol norow;
run;

/* remember no list here */
proc freq data=sashelp.class ;
tables age*sex / missing nocum nopercent nocol norow;
run;
