* Program 10.4.1b.sas
* Defining an autocall library;

filename grp5mac 'c:\group5\macros';
filename prj5Amac 'c:\group5\prjA\macros';
options mautosource sasautos=(prj5amac, grp5mac, sasautos);

 
