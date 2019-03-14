* Program 11.1.2a.sas
* Creating a vertical list from a control file;

proc sort data=macro3.clinics(keep=clinnum)
          out=clincodes
          nodupkey;
   by clinnum;
   run;
data _null_; 
   set clincodes end=eof; 
   call symputx(catt('clin',_n_),clinnum);  
   if eof then call symputx('clincnt',_n_); 
   run;
%put _user_;
