* Program 7.1.3g.sas
* Surfacing hidden masking characters;

%macro stcodes(stcode=WA);
   %if CA=%str(&stcode)       %then %put &=stcode: State is California;
   %else %put &=stcode: State is NOT California;
%mend stcodes;

options mlogic;
%* These macro calls work as expected;
%stcodes(stcode=AK)
