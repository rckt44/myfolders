%* Program 5.5.8
%* Question #8
%* The macro variables &indat and &outdat appear in 
%* both macros (%REGTEST and %DOTESTS).
%* Will there be a macro variable collision?;

%macro regtest(indat,outdat);
  proc reg data=&indat;
  model count=distance;
  output out=&outdat r=resid;
  run;
%mend regtest;

%macro dotests(indat,outdat);
  data r1;
  set &indat;
  if station=1;
  run;
  %regtest(r1,r1out)

  data r2;
  set &indat;
  if station=2;
  run;
  %regtest(r2,r2out)
  
  data &outdat;
  set r1out r2out;
  run;
%mend dotests;

%dotests(biodat,bioreg)


