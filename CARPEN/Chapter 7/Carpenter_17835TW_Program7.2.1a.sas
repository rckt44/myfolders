* Program 7.2.1a.sas
* Using the %INDEX function;

%let x=Long Tall Sally;
%let y=%index(&x,Tall);
%put Tall can be found at position &y;

%let srch = Tall;
%let x=Long Tall Sally;
%let y=%index(&x,&srch);
%put &srch can be found at position &y;
