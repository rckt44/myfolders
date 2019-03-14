* Program 7.1.3c.sas
* Using %BQUOTE to mask a resolved single quote;
data _null_;
   call symputx('ttl',"Tom's Truck");
   run;

%put %bquote(|&ttl|);

title1 "&ttl";
title2 &ttl;
proc print data=sashelp.class;
   run;

* clear the hanging single quote;
* The warning comes from TITLE2;
';run;

title1 "%bquote(&ttl)";
title2 %bquote(&ttl);
proc print data=sashelp.class;
   run;

* For fun and to see if anyone ever looks at these programs,
* what would happen if &TTL contained a double quote?
* Take a guess and then run the following.  Did you guess right?;
data _null_;
   call symputx('ttl','Tom"s Truck');
   run;

%put %bquote(|&ttl|);

title1 "&ttl";
title2 &ttl;
proc print data=sashelp.class;
   run;


title1 "%bquote(&ttl)";
title2 %bquote(&ttl);
proc print data=sashelp.class;
   run; 
