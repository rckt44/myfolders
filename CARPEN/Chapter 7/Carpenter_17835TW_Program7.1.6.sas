* Program 7.1.6.sas
* Removing masking characters;

%let city = Miami;
%let nrcity = %nrstr(&city);
%let unq = %unquote(&nrcity);

%put &=city &=nrcity &=unq; 
