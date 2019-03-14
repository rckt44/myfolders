OPTIONS INTERVALDS=(semester=semester); 

DATA semester;
DO year=2014 TO 2017;

   /* Fall Semester */
   begin = NWKDOM(5,2,8,year); /* Last Monday in August */
   end = NWKDOM(3,6,12,year);  /* Third Friday in December */
   OUTPUT;

   /* Spring Semester */
   begin = NWKDOM(2,2,1,year+1); /* Second Monday in January of
                                    following calendar year */
   if begin eq HOLIDAY('MLK',year+1) then /* If MLK day, then Tuesday */
      begin = begin + 1;
   end = NWKDOM(2,6,5,year+1); /*  Second Friday in May */
   OUTPUT;

   /* Summer Session */
   begin = NWKDOM(1,2,6,year+1); /* First Monday in June */ 
   end = NWKDOM(3,6,8,year+1); /* Third Friday in August */
   OUTPUT;
END;
FORMAT begin end WEEKDATE.; /* Required */
RUN;

PROC PRINT DATA=semester NOOBS;
RUN;
