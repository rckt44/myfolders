* Program 10.6.7
* Using the %COMPSTOR to compile autocall macros;

* Compile selected autocall macros;
* PATHNAME must point to a location;
%compstor(pathname=c:\temp)

* Using a libref or fileref to point to a location;
%compstor(pathname=%sysfunc(pathname(mymacs)))

* Adding autocall macros to an established stored compiled macro library;
libname mymacs 'c:\temp';
options mstored sasmstore=mymacs;
%compstor(pathname=%sysfunc(pathname(mymacs)))
