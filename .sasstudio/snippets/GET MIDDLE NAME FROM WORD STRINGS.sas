data a;
input name $ 32.;
datalines;
kung jung kole kola
bung bola tom yala
aaks hoit toli
yaya toure
;
run;

/* THIS WORKS */
data last;
length middle $20;
set a;
FNAME=SCAN(NAME,1);
   LNAME=SCAN(NAME,-1);
wc=countw(name,' ');
middle=' ';
do i=2 to wc -1;/*it says here that, hey,start from second word,coz first word is first name and to the second last word i.e -1.coz the last word is last name*/
word=scan(name,i,' ');
call catx(' ',middle,word);
end;
run;

/* THIS IS COPIED FROM WEBSITE */
data _null_;
length middle $20;
   set ds;

   count = countw(name, ' ');
   
   middle = ' ';
   
   do i = 2 to count -1;
      word = scan(name, i, ' ', 'm');
      call catx(' ', middle, word);
   end;
   put name = middle =;
run;