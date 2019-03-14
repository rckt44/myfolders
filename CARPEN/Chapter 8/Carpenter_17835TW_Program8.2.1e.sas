* Program8.2.1e.sas
* Using CALL EXECUTE with %SYMDEL;

%macro delvars;
  data vars;
    set sashelp.vmacro;
    where scope='GLOBAL' & substr(name,1,3) ne 'SYS';
    if name ne lag(name) then output vars;
    run;
  data _null_;
    set vars;
    call execute('%symdel '||trim(left(name))||'/nowarn;');
    run;
%mend delvars;

%let nada=;
%let dsn=clinics;
%delvars
%put _global_;
