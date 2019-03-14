* Program 10.3.4a.sas
* Using stored compiled macro libraries;

options mprint;

%macro doboth(indata=,vlist=,cnt=10);
     %if &vlist ne %then %sortit(dset=&indata, bylist=&vlist);
     %else %put SORTIT was not called;
     %look(dsn=&indata,obs=&cnt)
%mend doboth;

%put %quote(%doboth());

 
