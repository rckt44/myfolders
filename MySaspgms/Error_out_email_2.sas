	%let dpath=/folders;
	%let fpath=/myfolders/;
	%let pgmname=logerr;
	%put &=dpath;
	%put &=fpath;
	%put &=pgmname;


proc printto log="&dpath&fpath&pgmname..txt" new;run;

%macro forceerr;
data ferr;
	set sashelp.cars;
	force this error;
	why this error;
	what the fuck;
	run it anyway;
run;
proc print data=mylife;
run;
proc tabulate data=silife;
	class one two there;
	table one*var;
run;
%mend forceerr;
%forceerr;
proc printto;run;
/*=================================================*/
filename init "&dpath&fpath&pgmname..txt";
data readit(keep=alert flag);
	length Error $ 200.;
	infile init truncover;
	input @1 alert $5. @6 full $200. @;
	if alert='WARNI' OR alert='ERROR' then do;
	input @1 flag $200. @;
	end;
	if compress(alert,':')='NOTE' then do;
	input @1 flag $200. @;
	end;
	if not missing(flag);
run;

data clean;
	set readit;
	alert=compress(alert,':');
run;

proc sort data=clean nodupkey;
	by alert;
run;


data want;
	set clean;
	if alert not in('ERROR') then 
	call symputx('stop','');
	else
	call symputx('stop','*');
run;
%put &=stop;


















/*==================================================*/
************TO CREATE THE MACRO VARIABLE ERRORCHECK************;
DATA _NULL_;
	SET TABLE2;
	%IF &CNT.>0 %THEN %DO;
	CALL SYMPUT('LOGCHECK','*');
	%END;
	%ELSE %DO;
	CALL SYMPUT('LOGCHECK',' ');
	%END;
RUN;
%put &LOGCHECK.; 
/* get macro for email */
data _null_;
set readit;
call symputx()
************MACRO TO SEND MAIL************;
%let mailid=neupane.sas@gmail.com;
%put &=mailid;

%MACRO MAIL;
	FILENAME OUTMAIL EMAIL "&MAILID." SUBJECT="LOG CHECK REPORT FOR &LOGNAME."
	ATTACH=("&LOGNAME." "&A._logcheck.txt");
%put 'this is test';
RUN;
%MEND MAIL; 




