* Program 10.3.5.sas
* Using %SYSMACDELETE;

%macro doboth(indata=,vlist=,cnt=10)/secure;
     %if &vlist ne %then %sortit(dset=&indata, bylist=&vlist);
     %else %put SORTIT was not called;
     %look(dsn=&indata,obs=&cnt)
%mend doboth;

%macro aerpt(dsn, stdate, aelist);
   %put testing AERPT;
%mend aerpt;

%sysmacdelete doboth;
%sysmacdelete aerpt;
