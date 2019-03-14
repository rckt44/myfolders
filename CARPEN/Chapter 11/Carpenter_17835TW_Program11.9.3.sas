* Program 11.9.3.sas
* Specify an AUTOEXEC.SAS;

%* Establish GLOBAL Macro variables for this application; 
%* Set up the general path for this application;
   %global /readonly path=e:\clinical\GHIResearchINC; 
%* Project name;
   %global /readonly project = Protocol123;  
%* Environment - test (tst) or production ( );
   %global /readonly tst =;       %* Production;  
   %*global /readonly tst = tst;   %* Test environment;  

* Define the location for the autocall macro libraries;
options  mautosource
         sasautos=("&path\&project&tst\SASpgms\sasmacros"  
                   "&path\allproj\SASpgms\sasmacros");

* Define Librefs and Filerefs for this project;
%libnames 
