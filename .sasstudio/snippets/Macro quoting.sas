%let td= %str (in(
'CARS',
'CLASS',
'AIR',
'BEI',
'BMT',
'BUY',
'ZTC',
'ZHC',
'YR111',
'WORKERS',
'AACOMP',
'AARFM',
'BASEBALL',
'BWEIGHT',
'CLASSFIT',
'CNTAINER',
'COLUMN',
'COMET',
'ENSO',
'FAILURE',
'FISH',
'FEEDER',
'FSAUTH',
'FSHEAD',
'GAS',
'GCSTATE',
'GCTYPE',
'GNP',
'GRIDDED',
'HEART',
'HOLIDAY',
'IMAGERW',
'IRIS',
'JAC',
'JUNKMAIL',
'KOC',
'LAKE',
'LOC'))
;
%Put &=td;

%put _user_;
options symbolgen mprint mlogic;
proc sql;
create table bb as 
select memname as dsn,nobs as cnt from dictionary.tables 
where upcase(libname)='SASHELP'
and upcase(memname) 
&td;
quit;



