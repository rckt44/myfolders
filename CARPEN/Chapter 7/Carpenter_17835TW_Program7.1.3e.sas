* Program 7.1.3e.sas
* Masking special characters inside of a macro;
%macro stcodes(stcode=WA);
   %if CA=&stcode %then %put &=stcode: State is California;
   %else %put &=stcode: State is NOT California;
%mend stcodes;

%* These macro calls work as expected;
%stcodes(stcode=AK)
%stcodes(stcode=CA)
%stcodes(stcode=%bquote(OR))

%* This macro call causes an error;
%stcodes(stcode=OR)

%* Revised macro;
%macro stcodes(stcode=WA);
   %if CA=%bquote(&stcode) %then %put &=stcode: State is California;
   %else %put &=stcode: State is NOT California;
%mend stcodes;

%* These macro calls work as expected;
%stcodes(stcode=AK)
%stcodes(stcode=CA)
%stcodes(stcode=%bquote(OR))
%stcodes(stcode=OR)


