OPTIONS INTERVALDS=(proddays=workdays);
DATA workdays (KEEP=begin);
   start = '01JAN2014'D;
   stop  = '31DEC2015'D;
   nweekdays = INTCK('WEEKDAY',start,stop);
   DO i = 0 TO nweekdays;
      begin = INTNX('WEEKDAY',start,i);
      year = YEAR(begin);

	  /* Company-specific holidays */
	  xthanks = HOLIDAY("THANKSGIVING",year) + 1; /* Company closes day after thanksgiving */
	  xmaseve = HOLIDAY('CHRISTMAS',year) - 1;  /* Christmas Eve */
      sprng = HOLIDAY("EASTER",year) - 2; /* Friday before Easter */
	  founders = MDY(8,6,year); /* Founders Day */
	  SELECT(WEEKDAY(founders)); /* If on weekend, move forward/back as appropriate */
        WHEN(7) founders = founders-1;
        WHEN(1) founders = founders + 1;
        OTHERWISE founders= founders;
      END;

      /* Exclude holidays from dataset */
      IF begin NE HOLIDAY("NEWYEAR",year) AND 
         begin NE HOLIDAY("MLK",year) AND 
         begin NE HOLIDAY("USPRESIDENTS",year) AND 
         begin NE HOLIDAY("MEMORIAL",year) AND 
         begin NE HOLIDAY("USINDEPENDENCE",year) AND 
         begin NE HOLIDAY("LABOR",year) AND 
         begin NE HOLIDAY("VETERANS",year) AND 
         begin NE HOLIDAY("THANKSGIVING",year) AND 
         begin NE HOLIDAY("CHRISTMAS",year) AND 
         begin NE xmaseve AND 
         begin NE xthanks AND 
         begin NE sprng AND 
         begin NE founders THEN
      OUTPUT;
   END;
   FORMAT begin DATE.;
RUN;

DATA CountDays;
   start = '01JAN2014'D;
   stop  = '01JAN2015'D;
   ActualDays = INTCK('DAYS',start,stop);
   Weekdays   = INTCK('WEEKDAYS',start,stop);
   ProductionDays = INTCK('PRODDAYS',start,stop);
   FORMAT start stop DATE9.;
RUN;

PROC PRINT DATA=CountDays NOOBS LABEL;
RUN;

DATA production_lines;
LENGTH product $ 40;
   orderDate = "27JUN2014"d;
   Product = "Std Product 1";
   days_from_order = 23;
   OUTPUT;
   Product = "Std Product 2";
   days_from_order = 32;
   OUTPUT;
   Product = "Std Product 3";
   days_from_order = 35;
   OUTPUT;
   Product = "Custom Product 1";
   days_from_order = 33;
   OUTPUT;
   Product = "Custom Product 2";
   days_from_order = 42;
   OUTPUT;
   Product = "Custom Product 3";
   days_from_order = 56;
   OUTPUT;
   FORMAT orderdate weekdate.;
RUN;

DATA ordertime;
SET production_lines;
deliveryDate = INTNX('PRODDAYS',orderdate,days_from_order,'S');
approx_deliveryDate = INTNX('WEEKDAY',orderdate,days_from_order,'S');
FORMAT deliverydate approx_deliveryDate weekdate.;
RUN;

PROC PRINT DATA=ordertime NOOBS LABEL;
VAR product days_from_order approx_deliverydate deliverydate;
RUN;
