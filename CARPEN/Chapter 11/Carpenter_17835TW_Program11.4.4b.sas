* Program 11.4.4b.sas
* Count the words in a horizontal list of values;

%macro countw(list,dlm);
   %* Count the number of words in &LIST;
   %if %length(&dlm)=0 %then %sysfunc(countw(&list));
   %else %sysfunc(countw(&list,&dlm));
%mend countw;

%let vars = name/sex\age weight height;
%put The number of words in |&vars| is %countw(&vars,%str( /\));
%put The number of words in |&vars| is %countw(&vars);
