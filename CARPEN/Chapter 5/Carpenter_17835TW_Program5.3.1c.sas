* Program 5.3.1c
* Using a %DO block to enclose a complete statement;

%macro senrate(num=);
 
...code not shown...

data senrate.rtsen&num;
set ratedata&num;
* Create the variable GENDER 
* based on the variable SEX.
*   Table 5 Rename SEX to GENDER;
*   Table 3 & 7 use a format to define GENDER;
%if &num=5 %then %do;
   rename sex = gender; 
%end; 
%else %do;
   gender = put(sex, $sexdef.); 
%end;

...code not shown...

%mend senrate;
