* Program 6.2.1
* Storing a count in a macro variable;
%let cln = Beth;
proc sql noprint;
  select count(*)
    into :nobs
      from macro3.clinics(where=(clinname=:"&cln"));
  quit;
%put number of clinics for &cln is &nobs;

%let nobs=&nobs;
%put |&nobs|;
