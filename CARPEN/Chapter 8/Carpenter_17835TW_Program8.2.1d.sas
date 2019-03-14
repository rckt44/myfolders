* Program8.2.1d.sas
* Using quoting with %SYMDEL;

%let nada=;
%let dsn=clinics;
%let maclist = nada dsn;
%unquote(%nrstr(%symdel) &maclist / nowarn);
