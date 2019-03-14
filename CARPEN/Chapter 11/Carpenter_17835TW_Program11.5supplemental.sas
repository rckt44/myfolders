* Program 11.5.sas
* Using CALL EXECUTE to process a control file;

%* Test version of the SURVIVAL macro to check parms;
%macro survival(anumb=, acode=, atype=, refpopcode=, 
                activevar=, regimen=, eventcode=);
   %* Test parms transfer;
   %put *******&=anumb *****;
   %put _local_;
%mend survival;

filename xlscntrl "&path\data\control.csv";   

data _null_;
   infile xlscntrl dlm=',' truncover firstobs=2;
   length number code analysistype refpop censorrule eventcode arvregimen $8;
   input number $ code $ analysistype $ refpop $ censorrule $ eventcode $ arvregimen $;

   if censorrule ne '-' then censor=censorrule;
   else censor=' ';

   * create a variable to show what the argument to CALL EXECUTE looks like.;
   val = catt(
         '%survival(anumb=',number,
                ',acode=',code,
                ',atype=',analysistype,
                ',refpopcode=',refpop,
                ',activevar=',censor,
                ',regimen=',arvregimen,
                ',eventcode=',eventcode,
                ')'
             );
   put val;
   run;
