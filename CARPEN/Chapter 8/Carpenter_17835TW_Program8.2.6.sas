* Program 8.2.6
* Declaring macro variables to be READONLY;

%global/readonly mypath = &path;
%put _user_;

%let mypath = abc;

%global/readonly mypath = abc;

%symdel mypath;


%global/readonly a=a b=b c=c;
%put _user_;

%* show that a previously declared local macro 
%* variable precludes the global readonly declaration;
%macro checkit;
%local yourpath;

%let yourpath = abc;

%global/readonly yourpath = &path;
%put _user_;
%mend checkit;
%checkit
