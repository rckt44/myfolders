* Program6.3.3b.sas
* Using resolve to build a DATA step variable value;

data list;
drop Yesterday;
if _n_ = 1 then do;  /* create the macro vars */
    Yesterday = today()-1; /* assumes this step run after midnight */
    call symputx('ddmmyy',put(Yesterday,ddmmyy6.));
    call symputx('yymmdd',put(Yesterday,yymmdd6.));
    call symputx('monyy' ,put(Yesterday,monyy5.));
    call symputx('monyyyy',put(Yesterday,monyy7.));
end; /* create the macro vars */
format prefix dsname $44.;
input prefix $;
dsname = resolve(prefix);
datalines;
RESOLVES.TO.YESTERDAY.D&ddmmyy 
ALSO.RESOLVES.TO.YESTERDAY.A&yymmdd
RESOLVES.TO.MONTH.AND.YEAR.&monyy
RESOLVES.TO.MONTH.AND.FOUR.DIGIT.YEAR.&monyyyy
run;

title 'Sample Substiution for File Names';
proc print data = list;
id prefix;
var dsname;
run;
