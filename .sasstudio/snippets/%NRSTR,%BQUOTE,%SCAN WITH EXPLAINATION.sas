%let x=%nrstr(this i%s my house);
/* here nrstr says to macro processer,hey i have this special symbol in value %,please close your  */
/* eyes while compileing it,or per se,don't execute it.so the values as passed as it is  */
%let y=%bquote(&x);

/* here bquote says,hey,macro processer,please execute the &x but ,remember it has special */
/* symbol inside it and please keep that as it is.meaning mask it.and don't get confused by  */
/* it.it also says,the special symbol % is there to be,not for you to execute it. */
/* remember,% and & are macro triggers,they resolve before anything is even compiled. */

data _null_;
y=%scan(&x,1);
/* here ,just scanning and assigning the output value to the variable y. */
%put this is the value of y=%qscan(&x,1);
/* here,writing the resulting value of y to the log for us to read,see */
run;