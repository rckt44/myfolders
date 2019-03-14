* Program 8.3.3d
* Using SYSPBUFF to create a flexible IN operator;

%macro ORlist() / pbuff;
   %local datvar i parm orlist;
   %let datvar = %qscan(&syspbuff,1,%str(%(,)); 
   %let i = 1;
   %do %while(%qscan(&syspbuff,&i+1,%str(,%(%))) ne %str());
      %let parm = %qscan(&syspbuff,&i+1,%str(,%(%))); 
      %if &i=1 %then %let orlist = &datvar=&parm; 
      %else %let orlist = &orlist or &datvar=&parm;
      %let i = %eval(&i + 1);
   %end;
   &orlist 
%mend orlist;


%put If %orlist(cpt,'4300','4301',:'44',:'451') then...;
