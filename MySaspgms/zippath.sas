/* path to zip v1.0 */

data have;
length path $50.;
input path ;
cards;
Y:/user/kneupane/prod/bbc/data/need
Y:/user/bibi/roka/data/rosita
Y:/usr/you/data/khilaram
;
run;


/* get the path where you want to zip */
/* method-2 */
data need;
set have;
get=scan(path,-1,'/');
get2=lengthc(scan(path,-1))+1;
call symputx ('len',get2);
zip=substr(path,1,length(path)- &len);
run;
%put &=len;




