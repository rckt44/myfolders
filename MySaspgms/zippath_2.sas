/* pgm name: path to zip v2.0 */

data have2;
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
data need3;
set have2;
	do i =1 to 3;
	get2=(lengthc(scan(path,-1))+1);/*dont' remove this line,you need this for reference to 
	know whats happening in below line*/
	/*length(path)=total lenght of path
	(lengthc(scan(path,-1))+1)=lenght of last string plus one for delimiter*/
	zip=substr(path,1,length(path)- (lengthc(scan(path,-1))+1));
	end;
run;




