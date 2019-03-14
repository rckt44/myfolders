/* get n nmiss of mgr by job */
/* count of age by sex */
/* minimum age by sex */
/* maximum age by sex */

proc means data=sashelp.class;
class sex;
var age;
output out=a(drop=_type_ _freq_) n= min= max= / autoname;
run;

/* get n nmiss of mgr by job */
proc means data=emptable.emp n nmiss ;
class job;
var mgr;
output out=want(drop=_type_ _freq_ _stat_);
/* var comm; */
run;
