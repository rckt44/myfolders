proc delete data=samplejan sample;run;

data d20161;
input id date date9. mob purchase;
FORMAT DATE DATE9.;
datalines;
90 12JAN2016 3 0
91 14JAN2016 1 1
92 15JAN2016 3 0
93 16JAN2016 2 0
94 17JAN2016 1 1
95 18JAN2016 1 1
96 19JAN2016 1 1
97 20JAN2016 1 1
98 21JAN2016 1 1
99 22jan2016 1 0
;
run;
data d201601;
set d20161;
new_mon=month(date);
run;

/* for february */
data d20162;
input id date date9. mob purchase;
FORMAT DATE DATE9.;
datalines;
90 12FEB2016 3 0
91 14FEB2016 1 1
92 15FEB2016 3 0
93 16FEB2016 2 0
94 17FEB2016 1 1
95 18FEB2016 1 1
96 19FEB2016 1 1
97 20FEB2016 1 1
98 21FEB2016 1 1
99 22FEB2016 1 0
;
run;


data d201602(drop=date);
set d20162;
new_date=month(date);
run;

/* for march */

data d20163;
input id date date9. mob purchase;
FORMAT DATE DATE9.;
datalines;
90 12MAR2016 3 0
91 14MAR2016 1 1
92 15MAR2016 3 0
93 16MAR2016 2 0
94 17MAR2016 1 1
95 18MAR2016 1 1
96 19MAR2016 1 1
97 20MAR2016 1 1
98 21MAR2016 1 1
99 22MAR2016 1 0
;
run;


data d201603(drop=date);
set d20163;
new_date=month(date);
run;

/* for april */


data d20164;
input id date date9. mob purchase;
FORMAT DATE DATE9.;
datalines;
90 12APR2016 3 0
91 14APR2016 1 1
92 15APR2016 3 0
93 16APR2016 2 0
94 17APR2016 1 1
95 18APR2016 1 1
96 19APR2016 1 1
97 20APR2016 1 1
98 21APR2016 1 1
99 22APR2016 1 0
;
run;


data d201604(drop=date);
set d20164;
new_date=month(date);
run;

/* WRITING A DO LOOP MACRO TO READ ALL 4 MONTHS DATA APPEND EACH RESULT TO EARLIER RESULTS */

%macro test(infil=,outfil=);
proc sql;
create table &outfil as
select new_date,(sum(case when mob=1 then mob end)/sum(purchase) )as kk format percent.
from &outfil
group by 1;
run;
%mend test;

%TEST(INFIL=D201601,OUTFIL=JAN);
%TEST(INFIL=D201602,OTUFIL=FEB);
%TEST(INFIL=D201603,OUTFIL=MAR);
%TEST(INFIL=D201604,OUTFIL=APR);





