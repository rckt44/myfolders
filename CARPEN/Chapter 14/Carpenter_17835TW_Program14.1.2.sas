* Program 14.1.2.sas
* Retriving an element from a macro list;

%macro getkeys(inlib,indsn);
%* getkeys.sas
* ROSmith
* Macro to get the key variables for selected library & member.
* Assumes that the global macros for the databases & keys 
* are created.
* Outputs a global macro variable KEYVARS.
*;
%global keyvars;
%do k = 1 %to &&&inlib.cnt; 
   %if %upcase(&indsn) = %upcase(&&&inlib.db&k) %then 
        %let keyvars = &&keys&k; 
%end;
%mend getkeys;  

%let finaldb1 = demog; %let keys1=subject;
%let finaldb2 = medhist; %let keys2=subject medhisno seqno;
%let finalcnt = 2;

%getkeys(final,medhist)
%put &=keyvars;
