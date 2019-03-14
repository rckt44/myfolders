* Program 11.2.8b.sas
* Using the vertical lists to build macro calls;

%do k = 1 %to &count;
   %survival(anumb=&&anumb&k,
             acode=&&acode&k,
             atype=&&atype&k,
             refpopcode=&&refpop&k,
             activevar=&&censor&k,
             regimen=&&arvreg&k,
             eventcode=&&eventcode&k)
%end;
