* Program 8.1.4.sas
* Determine if a SAS product has been licensed at your site;

%macro Checkprod(prod=);
   %if %sysprod(&prod)=1 %then %put &prod is available;
   %else %if %sysprod(&prod)=0 %then %put &prod is not available;
   %else %if %sysprod(&prod)=-1 %then %put &prod is unknown;
%mend checkprod;

%checkprod(prod=sasgraph)
%checkprod(prod=graph)
%checkprod(prod=gis)
