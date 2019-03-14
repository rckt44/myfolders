* Program 7.1.7b.sas
* Using %SUPERQ to test for null values;

%macro test4null(val);
%if %sysevalf(%superq(val)=,boolean) %then %put the value is null;
%mend test4null;

%test4null(abc)
%test4null()
