* Program 7.1.4c.sas
* Compilation time (%STR) and Execution time (%BQUOTE) functions;

%let state=|;

%**** STR;
%* Fails;
%macro tst;
%if %str(&state)=CA %then %put equal;
%else %put not equal;
%mend tst;
%tst 
%* OK;
%macro tst;
%if %str(|)=CA %then %put equal;
%else %put not equal;
%mend tst;
%tst


%**** BQUOTE;
%* OK;
%macro tst;
%if %bquote(&state)=CA %then %put equal;
%else %put not equal;
%mend tst;
%tst 
%* OK;
%macro tst;
%if %bquote(|)=CA %then %put equal;
%else %put not equal;
%mend tst;
%tst
