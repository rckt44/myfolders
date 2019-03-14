* Program 14.3.6g.sas
* Using a compound range expression;
 
%macro checkit(val);
   %if -5 le &val le 0 %then %put &val is in neg range (-5 to 0);
   %if 1 le &val le 5 %then %put &val is in pos range (1 to 5);
%mend checkit;

%macro checkit(val);
   %if -5 le &val and &val le 0 %then %put &val is in neg range (-5 to 0);
   %else %if 1 le &val and &val le 5 %then %put &val is in pos range (1 to 5);
   %else  %put &val is out of range (-5 to 5);
%mend checkit;
%checkit(-10)
%checkit(-2)
%checkit(2)
%checkit(10)

