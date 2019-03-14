* Program 10.3.3b.sas
* Using stored compiled macro libraries;

options mstored sasmstore=macro3;

%macro aerpt(dsn, stdate, aelist) /store source ;
   %put testing AERPT;
%mend aerpt;

%aerpt()

%copy aerpt/source;

%copy aerpt / lib=macro3
              out='c:\temp\aerpt2.sas'
              src;

