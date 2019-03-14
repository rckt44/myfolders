* Program 7.1.4a.sas
* Quoting before or after resolution;

%let city = Miami;
%put %nrstr(&city) is on the water.;

%let store = A&P;
%put The store name is &store;

%let store = %nrbquote(A&P);
%put The store name is &store;

%let store = %nrstr(A&P);
%put The store name is &store;
