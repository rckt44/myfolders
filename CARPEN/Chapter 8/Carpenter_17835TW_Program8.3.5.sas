* Program 8.3.5.sas
* Display the name an executing macro;

%macro inner;
%put inner &sysmacroname;
%mend inner;
%macro test;
%put in test before inner: &sysmacroname;
%inner
%put back in test: &sysmacroname;
%mend test;
%test
%put in open code: &sysmacroname;
