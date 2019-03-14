* Program 11.1.2b.sas
* Creating a horizontal list from a control file;

proc sql noprint;
   select distinct clinnum
      into :clinlist separated by ' '
         from macro3.clinics(keep=clinnum);
   %let clincnt=&sqlobs;
   quit; 

%put &=clincnt &=clinlist;
