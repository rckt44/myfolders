* Program 8.2.3b.sas
* Capture a data set name using a %WINDOW;

%* Bring in the two digit year using a user prompt;
%* Prompt for the year;
%window getyear
   color=magenta
   icolumn=15
   irow=10
   columns=30
   rows=15
   #3 @3  'Enter the two digit year' color=white
   #4 @5 yr 2 color=white attr=underline required=yes
   #5 @3 'Then press "Enter" '  color=white
   ;
%display getyear;
