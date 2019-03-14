* Program 9.1.1a.sas
* Resolving Macro calls containing macro variable references;

%let version = new;
%macro debug;
   %put aaa;
%mend debug;
%macro debugnew;
   %put New to me.;
%mend debugnew;

%debug&version

%* Execute %DEBUG then resolve &version;
%debug%unquote(%nrstr(&version))

%* Execute the macro %DEBUGNEW, force resolution of &version first;
%unquote(%nrstr(%debug)&version);
