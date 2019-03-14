* Program 10.3.6.sas
* Using %SYSMSTORECLEAR;

libname macro3 "&path\data";
options mstored sasmstore=macro3;

%macro doboth(indata=,vlist=,cnt=10)/store;
     %if &vlist ne %then %sortit(dset=&indata, bylist=&vlist);
     %else %put SORTIT was not called;
     %look(dsn=&indata,obs=&cnt)
%mend doboth;

%sysmstoreclear;

libname macro3 'c:\temp';
%macro aerpt(dsn, stdate, aelist) / store;
   %put testing AERPT;
%mend aerpt;
