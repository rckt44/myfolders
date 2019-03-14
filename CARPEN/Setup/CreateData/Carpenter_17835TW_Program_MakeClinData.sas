* MakeClinData.sas
* Create the sample study data;

data macro3.Demog;
infile cards truncover dsd dlm=' ';
length subject $8 ptinit $8 Center $3 DOB 8 Sex Race $1 ;
input subject $ ptinit $ Center $  DOB :date9. Sex $ Race $ ;
Datalines;
100 abc A35 14may1950 M 2
104 def A35 27Jun1960 F 5
204 ghi ' ' 05feb1965 m 3
run;

data macro3.MedHis;
infile cards truncover;
length subject $8 ptinit $8 seqno MedHisNo 8 MHDT 8; 
input subject $ ptinit $ seqno MedHisNo   MHDT :date9.  ;
Datalines;
100 abc 1 100 17jan2010 
100 abc 2 100 29mar2010 
104 def 1 104 31feb2010 
204 ghi 1 104 17mar2010 
run;

data macro3.PhysExam;
infile cards truncover;
length subject $8 ptinit $8 Visit SeqNo PHDT WT 8; 
input subject $ ptinit $ visit seqno PHDT :date9. WT;
Datalines;
100 abc 1 1 27jun2015 168
100 abc 2 2 15jul2015 172
104 def 1 1 03feb2015 150
204 ghi 1 1 11nov2015 187
run;
