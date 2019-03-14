* Program 7.2.6.sas
* Demonstrating the %LEFT and %QLEFT functions;

data _null_;
   x=5;
   store = '    A&P';
   citystate = '   Seattle, WA';
   call symput('five',x);
   call symputx('store',store);
   call symputx('cs',citystate);
   run;

%put  Unjustified |&five|;
%put Left Justified |%left(&five)|;

%* Resolved & causes an error;
%put Left Justified |%left(&store)|;
%put QLeft Justified |%qleft(&store)|;
%let qstore = %qleft(&store);
%put The ampersand is quoted &qstore;

%* The first two %LET statements fail;
%let lcity1 = %left(&cs);
%let lcity2 = %qleft(&cs);
%let lcity3 = %qleft(%bquote(&cs));
%put |&lcity3|;

%let juststore = &cs;
%put |&juststore|;
