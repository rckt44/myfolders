* Program 7.2.8.sas
* Demonstrating the %TRIM and %QTRIM functions;

data _null_;
   name='Joe      ';
   call symput('name',name);
   run;
%let qname = %bquote(Sam        );

%put |&name|;
%put |&qname|;

%put |%trim(&name)|;
%put |%trim(&qname)|;
%put |%qtrim(&qname)|;

%* Trim using %LET;
%let name = &name;
%let qname = &qname;
%let qname2 = %unquote(&qname);
%put |&name|;
%put |&qname|;
%put |&qname2|;


