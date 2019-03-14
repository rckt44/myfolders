data members;
input Member_id $ Plan_id $;
datalines;
164-234 XYZ
297-123 ABC
344-123 JKL
395-123 XYZ
495-987 ABC
562-987 ABC
697-123 XYZ
833-144 JKL
987-123 ABC
;
data plans;
input Plan_id $ Plan_desc $;
datalines;
XYZ HMO_Salaried
ABC PPO_Hourly
JKL HMO_Executive
;
/* ************************* */
data both2;
declare hash plan();
rc=plan.definekey('Plan_id');
rc=plan.definedata('Plan_desc');
rc=plan.definedone();

do until(eof1);
set plans end=eof1;
rc=plan.add();
end;

do until(eof2);
set members end=eof2;
call missing(Plan_desc);
rc=plan.find();
output;
end;
stop;
run;









/*  */
data both(drop=rc);
        declare Hash Plan ();
         rc = plan.DefineKey ('Plan_id');
         rc = plan.DefineData ('Plan_desc');
         rc = plan.DefineDone ();
        do until (eof1) ;
           set plans end = eof1;
           rc = plan.add ();
end;
        do until (eof2) ;
           set members end = eof2;
           call missing(Plan_desc);
           rc = plan.find ();
           output;
end;
stop; 
run;
/*  creating my own data set to join in class table*/
/* base table */

proc delete data=work._all_;run;
/*  base file */
data classtwo;
format sports $ 12.;
input Age $ sports $;
infile datalines dlm=',';
informat sports $ 12.;
datalines;
14,volleyball
13,soccer
16,icehockey
15,basketball
12,baseball
11,tennis
;
run;
/* compare file one */
data classone;
input Age $ name $;
infile datalines dlm=',';
datalines;
12,kanchan
14,sunaina
15,roman
16,amir
11,josu
13,roku
;
run;
/*  */
/* compare file two */
data classthree;
input Age $ location $;
infile datalines dlm=',';
datalines;
12,chicago
14,texas
15,va
16,boston
11,nj
13,ny
;
run;

data classy_2;
	declare hash sprts();
	rc=sprts.definekey('Age');
	rc=sprts.definedata('sports');
	rc=sprts.definedone();
	
		do until (eof1);
		set classtwo end=eof1;
		rc=sprts.add();
		end;
		
	declare hash loc();
	rc=loc.definekey('Age');
	rc=loc.definedata('location');
	rc=loc.definedone();
	
		do until (eof2);
		set classthree end=eof2;
		rc=loc.add();
		end;
		
do until(eof3);
set classone end=eof3;
call missing (sports);
call missing (location);
rc=sprts.find();
rc=loc.find();
output;
end;
stop;
run;













