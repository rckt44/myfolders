

	proc sort data=demographic;by patient_id;run;
	proc sort data=prescription;by patient_id;run;
	proc sort data=medical;by patient_id;run;

%let dt=01012001;
%put &=dt;
/* Task 1 */
data fnl;
	merge demographic(in=a) 
	prscription(in=b rename=(drugcode=dcode pills=pil)) 
	medical(in=c);
	by patient_id;
	if 13<=yrdif(birthdate, "&dt", 'AGE')<=18 then Teen='Yes';
	else Teen='NO';
	age = INT(YRDIF(BirthDate, "&dt",'ACTUAL'));

	drugcode=put(dcode,best12.);
	pills=	 put(pil,best12.);
run;
/* get teen out */
data teenout;
	set fnl;
	if compress(Teen) in ('Yes') then output;
run;
/* Task 2 phy subset */
data phyvisitrecs;
	set medical;
	if upcase(compress(src)) in ('PHY')then output;
run;								
/* Task 3 */
data flagit;
	set fnl;
	array diag[3]diagnosiscode1-diagnosiscode3;
	do i=1 to dim(diag);
	if 000<=diag(i)<=100 then Dx_GP01=1;
	if 100<diag(i)<=200  then Dx_GP02=1;
	if 200<diag(i)<=300  then Dx_GP03=1;
	if 300<diag(i)<=400  then Dx_GP04=1;
	if 400<diag(i)<=500  then Dx_GP05=1;
	if 500<diag(i)<=600  then Dx_GP06=1;
	if 600<diag(i)<=700  then Dx_GP07=1;
	if 700<diag(i)<=800  then Dx_GP08=1;
	if 800<diag(i)<=900  then Dx_GP09=1;
	if 900<diag(i)<=999  then Dx_GP010=1;
	end;
run;
/* missing to zero */
proc stdize data=flagit reponly missing=0 flag_fnl=aa;run;

/* Task 4 Descriptive stat of Demograpy by patient_id*/
proc freq data=fnl;
	tables Teen*patient_id /missing;
	title " stat of patients/demography";
run;

/* Task 5 get ave age across all patients */
proc means data=fnl mean;
	var Age;
	title " ave age across all patients";
run;

/* Task 6 */
/* get number of patients on any drugs,physvisit,and both */
/* data on_drugs phy_visit drug_physvisit; */
data fnl_lst;
	set fnl(keep=fill_dt patient_id servicedate);
	/* if not missing(fill_dt) and fill_dt>today() then output on_drugs; */
	if not missing(fill_dt) and fill_dt>today() then on_drugs='Yes';
	
	/* if not missing(servicedate) and servicedate>today() then output phy_visit; */
	if not missing(servicedate) and servicedate>today() then phy_visit='Yes';
	
	/*if (not missing(fill_dt) and fill_dt>today() And not missing(servicedate)
	and servicedate>today()
	then output drug_physvisit);*/
	
	if (not missing(fill_dt) and fill_dt>today()) And (not missing(servicedate)
	and servicedate>today())
	then drug_n_physvisit='Yes';
run;

proc freq data=fnl_lst;
	title "# of patients /*";
	tables on_drugs / missing;
	tables phy_visit / missing;
	tables drug_n_physvisit / missing;
run;


/* Task 7 */
/*Report the distribution of: 
# of physician visits per patient, 
# of patients per drugcode, 
# of patients per diagnostic grouping, 
and # of prescriptions per drugcode.
# of patients per drugcode, */
proc freq data=Prescription;
	tables drugcode*patient_id / missing;
	title "# of patients / diag grp";
run;
proc freq data=Prescription;
	tables drugcode*fill_dt / missing;
	title "# of prescriptions / drug code";
run;










