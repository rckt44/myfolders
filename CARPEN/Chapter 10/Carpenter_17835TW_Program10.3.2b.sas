* Program 10.3.2b.sas
* Using stored compiled macro libraries;

libname projstor 'c:\myprojA\sasmacros';
libname allmstor 'f:\GroupProjA\saspgms\macros';
libname multi (projstor, allmstor);

options mstored sasmstore=multi;
 
