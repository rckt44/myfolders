* Program 7.1.3f.sas
* Surfacing hidden masking characters;

%let owner = %str(Tom%'s Truck);
%put &=owner;

%let vehiclecolor = &owner is blue;
%put &=vehiclecolor;
