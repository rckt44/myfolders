* Program 11.9.4.sas
* Using the %LIBNAMES macro to control LIBNAME and FILENAME generation;

%macro libnames;
* Libnames used in applications;
libname appls ("&path\allproj\SASpgms\appls"
               "&path\&project&tst\SASpgms\appls")
                access=readonly;

* Filenames;
filename dbdirsas "&path\allproj\SASpgms\primary\dedsn.sas";
filename vrdirsas "&path\allproj\SASpgms\primary\devar.sas";
filename cmprlog  "&path\&project&tst\list\compare\compare.log";
filename cmprlst  "&path\&project&tst\list\compare\compare.lst";

* Primary Project libnames;
libname coded "&path\&project&tst\dictnary\live\coded";
libname notcoded &path\&project&tst\dictnary\live\notcoded";
libname editlog "&path\&project&tst\data\live\editlog";
%mend libnames;
 
