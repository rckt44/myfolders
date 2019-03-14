* Program 5.2.2c
* Semicolon misplacement;

%macro senrate(num=);
 
...code not shown...

data senrate.rtsen&num;
set ratedata&num;
* Create the variable GENDER 
* based on the variable SEX.
*   Table 5 Rename SEX to GENDER;
*   Table 3 & 7 use a format to define GENDER;
%if &num=5 %then rename sex = gender; ; 
%else gender = put(sex, $sexdef.); ; 

...code not shown...

%mend senrate;
