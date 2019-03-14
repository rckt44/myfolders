* array1.sas ;
title1 'array1.sas' ;
options compress = yes nodate ;
data one;
input v1 - v3 ; cards ;
.2 .3 .4
.5 .6 .321
.21 .3 .4
.15 .36 .13
;
data two; set one ;
** Create variables without an array and do over loop ;
** With 3 variables - it doesn't make much difference - ;
** but imagine transforming MANY variables. You would ;
** have to type A LOT of lines - and could make many mistakes. ; 
a1 = v1 * 100 ;
a2 = v2 * 100 ;
a3 = v3 * 100 ;
run;

*** A simple example of ARRAYS and DO OVER *** ;
** Create new variables in an array from ;
** Existing variables - Also in an array. ;
**** When processing multiple arrays, it is IMPORTANT ;
**** to make check and make sure that you have the same ;
**** number of variables in the arrays - and that the variables; **** correspond to each other as you expect think they do. ;
** Each variable in the array is called an "element". ;
** Create new variables that are the original variables multiplied by 100. ;
** The syntax is: ARRAY (array name) (list of variables included in array) ;

data two; 
set one ;
array orig  v1 - v3 ;
array perc  p1 - p3 ;
** The arrays can be processed with a DO OVER loop. ;
** Within the DO OVER LOOP, when an ARRAY NAME is referred to, ALL of the ; ** variables in the LIST OF VARIABLES INCLUDED IN ARRAY are processed;
do over orig ;
perc = orig * 100 ;
end;
proc print ; run ;