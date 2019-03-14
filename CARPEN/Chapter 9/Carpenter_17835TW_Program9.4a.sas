* Program9.4a.sas
* Formatted lookups;

%macro findsite(site=Ketchikan);
%LET SITE=%UPCASE(&SITE); 
%if       &SITE EQ KETCHIKAN %then %let SCode=A_KTN_; 
%else %if &SITE EQ POW %then %let SCode=B_POW_; 
%else %if &SITE EQ PETERSBURG %then %let SCode=C_PTG_; 
%else %if &SITE EQ WRANGELL %then %let SCode=C_WRG_; 
%else %if &SITE EQ SITKA %then %let SCode=D_SIT_; 
%else %if &SITE EQ JUNEAU %then %let SCode=E_JNU_; 
%else %if &SITE EQ GUSTAVUS %then %let SCode=F_GUS_; 
%else %if &SITE EQ ELFIN COVE %then %let SCode=G_ELF_; 
%else %if &SITE EQ YAKUTAT %then %let SCode=H_YAK_; 
%else %let SCode=UNK_; 
%put &=site &=scode;
%mend findsite;
%findsite(site=Yakutat)
