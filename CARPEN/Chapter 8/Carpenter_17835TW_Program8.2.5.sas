* Program 8.2.5
* Deleting a macro from the WORK.SASMACR catalog;

%macro silly0;
%* silly0;
%mend silly0;
%macro silly1;
%* silly1;
%mend silly1;
%macro silly2;
%* silly2;
%mend silly2;
%sysmacdelete silly0;
%sysmacdelete silly1 silly2;
%sysmacdelete silly3;
%sysmacdelete silly3 /nowarn;

