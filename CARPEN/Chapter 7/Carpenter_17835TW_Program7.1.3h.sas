* Program 7.1.3h.sas
* Surfacing hidden masking characters;

%macro isitquoted(var=);
   %if &var ne %then %put &var;
%mend isitquoted;


options mlogic;
%let owner = %str(Tom%'s Truck);
%let vehiclecolor = &owner is blue;
%put &=vehiclecolor;
%isitquoted(var=&vehiclecolor)

options nomlogic;
/*%symdel path ttl lst;*/
/*%put   ;*/
%put _user_;
