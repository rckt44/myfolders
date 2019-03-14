* Program 11.2.8a.sas
* importing a CSV file;

filename xlscntrl "&path\data\control.csv";   

data _null_;
   infile xlscntrl dlm=',' truncover firstobs=2;
   length number code analysistype refpop censorrule eventcode arvregimen $8;
   input number $ code $ analysistype $ refpop $ censorrule $ eventcode $ arvregimen $;
   i+1;
   ii=left(put(i,4.));
   call symputx('anumb'||ii,trim(number),'l');
   call symputx('acode'||ii,trim(code),'l');
   call symputx('atype'||ii,trim(analysistype),'l');
   call symputx('refpop'||ii,trim(refpop),'l');
   if censorrule ne '-' then
     call symputx('censor'||ii,trim(censorrule),'l');
   else call symputx('censor'||ii,' ','l');
   call symputx('arvreg'||ii,trim(arvregimen),'l');
   call symputx('eventcode'||ii,trim(eventcode),'l');
   call symputx('count',ii,'l');
   run;
