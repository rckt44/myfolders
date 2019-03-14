* Program 8.3.3c
* Using SYSPBUFF to create a flexible IN operator;

%macro in() / parmbuff; 
  %local parms var numparms infunc i thisparm;
  %let parms = %qsubstr(&syspbuff,2,%length(&syspbuff)-2);  

  %let var = %scan(&parms,1,%str(,)); 

  %let numparms = %sysfunc(countw(&parms));

  %let infunc = &var eq %scan(&parms,2,%str(,));

  %do i = 3 %to (&numparms); 
    %let thisparm = %scan(&parms,&i,%str(,)); 
    %let infunc = &infunc or &var eq &thisparm; 
  %end;

  (&infunc) 
%mend;

%put If %in(cpt,'4300','4301',:'44',:'451') then...;
