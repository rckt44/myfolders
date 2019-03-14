* Program 7.2.3e.sas
* Using the %SCAN function to parse a list;

%macro cntvar(keyfld=);
     %global cnt;
     %let I = 1;
     %do %until(%scan(&keyfld,&I,%str( ))=%str());
        %global var&I;
        %let var&I = %scan(&keyfld,&I,%str( ));
        %let I = %eval(&I + 1);
     %end;
     %let cnt = %eval(&I-1);
%mend cntvar;
%cntvar(keyfld=region clinnum sex)
%*put _user_;

