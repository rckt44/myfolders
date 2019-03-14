%* Program 5.5.9
%* Question #9
%* Which comparisons in %TRY will evaluate to TRUE?;

%let a = AAA;
%macro try;
   %put &=a;
   %if  &a  	=	 AAA 	%then %put no quotes;
   %if '&a' 	=	'AAA'	%then %put single quotes;
   %if 'AAA'	=	'AAA'	%then %put exact strings;
   %if "&a" 	=	"AAA"	%then %put double quotes;
   %if "&a" 	=	'AAA'	%then %put mixed quotes;
   %if "&a" 	=	 AAA	%then %put quotes on one side only;
%mend try;
%try
