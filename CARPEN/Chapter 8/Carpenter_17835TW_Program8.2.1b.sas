* Program8.2.1b.sas
* Using %SYMDEL to delete macro variable lists;

%* delete these two variables from the global symbol table;
%let nada=;
%let dsn=clinics;
%let macvarlist = nada dsn xyz;
%symdel &macvarlist / nowarn;

%macro test(macvarlist= a b c);
%symdel &macvarlist / nowarn;
%mend test;
%let nada=;
%let dsn=clinics;
%test(macvarlist = nada dsn xyz)
%put &=nada  &=dsn;
