libname control "chap2ex";
options cmplib=(control.functions);
ods escapechar='~';

proc fcmp trace outlib=control.functions.dates;

   function makedate(cdate $)$;
      length dtstr $42
            supr   $16;
      supr=' ';
      /* assume that data is in MMDDYYYY form, but check */
	  /* Parse date string, get elements */
      cmo = scan(cdate,1,'/-.: ','M');
      cdy = scan(cdate,2,'/-.: ','M');
      cyr  = scan(cdate,3,'/-.: ','M');
	  if cyr eq ' ' or index(cyr,'_') gt 0 or cyr eq '.' then do;
	     y = .;
	  end;
      else do;
         y=input(cyr,4.);
	  end;

	  /* Test year value - earliest date is 1990, cannot be in future */
      if y ne . and (1990 lt y lt year(today())) then do;
         * assume year is good;
	     if cmo eq ' ' or index(cmo,'_') gt 0 or cmo eq '.' then
		    m = .;
		 else
            m=input(cmo,2.);
         if 1 le m le 12 then do; /* month has to be between 1 and 12 */
            /* Month is good chk day */
		    if cdy eq ' ' or index(cdy,'_') gt 0 or cdy eq '.' then
			   d = .;
			else
               d=input(cdy,2.);
            if d le 1 or d gt (day(intnx('month',mdy(m,1,y),0,'e'))) then do;
               /* Day is bad for this month - impute middle of month */
               d = ceil(day(intnx('month',mdy(m,1,y),0,'e'))/2);
               supr = '~{super Day}';
            end;
         end;
         else do;
            /* Month is bad - reset month and day */
            m=6;
            d=30;
            supr = '~{super Month}';
         end;
         /* Create the date value */
         date=mdy(m,d,y);
         dtstr = catt(put(date,mmddyy10.),supr);
      end;
      else do;
         /* yr is bad -flag */
         dtstr = 'Unknown~{super Y}';
      end;
      return(dtstr);
   endsub;
run;
quit;

proc format;
   value $mkdt
      other=[makedate()];
   run;

data errorcnt;
input recno @4 rptdt $10. errs;
datalines;
1  13/15/2013 374
2  09/08/2013 3
3  02/30/2013 32
4  __/15/2013 15
5  04/27/2013 195
6  05/__/2013 17
7  07/08/____ 20
8  06/04/013 5
9  08/32/2013 4
10 11//2013   6
11 01/23/2031 11
;;;;
run;

ods html close;
ods rtf file="dtfunction.rtf";
title1 'Error Counts by Date';
proc report data=errorcnt nowd split='\';
   column recno rptdt rptdt=dt errs;
   define recno / order 'Record #';
   define rptdt /  "Orignal\Date from\Error Log";
   define dt /  'Imputed\Date' f=$mkdt36.;
   define errs / "Errors\Reported";
   run;
ods rtf close;
