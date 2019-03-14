* Program 10.3.2d.sas
* Specifying READONLY stored compiled macro libraries;

libname projmac 'c:\myprojA\sasmacros' access=readonly;
options mstored sasmstore=projmac;
 
