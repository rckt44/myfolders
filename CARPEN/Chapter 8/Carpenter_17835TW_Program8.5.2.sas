* Program8.5.2.sas
* Deleting macro variables with the SYMDEL routine;

%global City;
%let city = Los Angeles;
%macro test;
%local city;
%let city=Anchorage;
%let state=Alaska;
data _null_;
   put 'Delete Global &CITY';
   call symdel("city");
   put 'There is no Global &CITY to delete';
   call symdel('city');
   put '&state does not exist in the global table';
   call symdel('state','nowarn'); 
   run;
%* show that the local version of &CITY still exists;
%put Within TEST &=city;
%mend test;
%test
%* is there a global version of &CITY?;
%put &=city;



