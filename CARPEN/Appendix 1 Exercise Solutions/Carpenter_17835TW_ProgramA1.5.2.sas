* Program A1.5.2
* Question #2
* Create %DO loops;

%macro loop1;
  %* Using the iterative %DO;
  %do cnt = 1 %to 10;
     %put This is Test &cnt;
  %end;
%mend loop1;

%macro loop2;
  %* Using the %DO %WHILE;
  %let cnt=1;
  %do %while(&cnt <= 10);
     %put This is Test &cnt;
     %let cnt = %eval(&cnt + 1);
  %end;
%mend loop2;

%macro loop3;
  %* Using the %DO %UNTIL;
  %let cnt=1;
  %do %until(&cnt > 10);
     %put This is Test &cnt;
     %let cnt = %eval(&cnt + 1);
  %end;
%mend loop3;

%put loop1; %loop1
%put loop2; %loop2
%put loop3; %loop3
