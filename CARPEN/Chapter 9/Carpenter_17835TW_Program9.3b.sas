* Program9.3b.sas
* Forming a simple hash;
* Single index and a known list of variables;

data _null_;
   set sashelp.class;
   call symputx(catx('_',name,'age'),age,'l');
   call symputx(catx('_',name,'sex'),sex,'l');
   call symputx(catx('_',name,'height'),height,'l');
   call symputx(catx('_',name,'weight'),weight,'l');
   run;

%put &=alice_height;
%put &=alfred_sex;
