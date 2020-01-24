* Program CA88Air.sas;
*
* Create the air quality data set.
*
* One observation per month (monthly average) 
* per station for several air quality measures
*************************************************;

data macro3.ca88air;
input @1  O3
      @6  CO
      @11 NO3
      @17 SO4
      @22 TEM
      @28 HUM
      @34 Date
      @40 Station $3.
      @44 Month
 ;
format date date9.;
label O3    = 'Ozone'
      CO    = 'Carbon Monoxide'
      NO3   = 'Nitrate'
      SO4   = 'Sulfate'
      tem   = 'Temperature F'
      hum   = 'Percent Humidity'
      date  = 'Date of Sample'
      station='Sample Location'
      month = 'Sample Month';
datalines;
1.58 1.35 10.96 3.18 54.9  59.5  10241 AZU 1
2.77 1.25 12.73 2.96 60.2  58.5  10272 AZU 2
3.59 1.26 15.5  6.11 62.8  58    10301 AZU 3
3.48 1.05 15.01 4.69 63.4  72.75 10332 AZU 4
4.53 0.95 19.69 6.06 67.6  70    10362 AZU 5
3.8  0.93 17.48 7.68 69    74.75 10393 AZU 6
4.84 0.97 19.32 9.41 76.5  79.5  10423 AZU 7
4.33 1.3  18.06 8.84 74.5  78.75 10454 AZU 8
3.95 1.46 17.36 7.95 72.9  75.75 10485 AZU 9
3.18 1.76 22.81 8.93 70.1  76.25 10515 AZU 10
2.18 1.71 14.22 5.59 60    70.75 10546 AZU 11
1.9  0.99 8.7   2.58 54.6  56.5  10576 AZU 12
0.78 1.36 5     2.78 51.9  .     10241 LIV 1
0.89 1.28 8.13  3.7  56.5  .     10272 LIV 2
1.64 0.98 3.58  3.63 59.1  .     10301 LIV 3
2.89 0.94 3.28  3.28 59    .     10332 LIV 4
2.75 0.89 2.6   2.6  59.9  .     10362 LIV 5
2.56 0.84 2.95  2.71 62.7  .     10393 LIV 6
2.66 0.88 3.74  3.72 65.1  .     10423 LIV 7
2.34 0.88 4.63  3.59 65.41 .     10454 LIV 8
2.7  1.06 4.18  3.9  62.1  .     10485 LIV 9
1.88 1.14 6.03  3.99 59.6  .     10515 LIV 10
1.31 1.08 1.94  2.38 54.5  .     10546 LIV 11
1.28 1.45 4.85  2.38 49.8  .     10576 LIV 12
1.28 2.44 4.34  4.25 50.6  77.75 10241 SFO 1
1.38 2.58 4.6   5.98 54.5  70.75 10272 SFO 2
1.6  2.05 1.56  4.83 56.5  68    10301 SFO 3
2.39 1.76 1.93  4.84 58.1  68    10332 SFO 4
2.35 1.58 1.82  3.5  59.5  69.5  10362 SFO 5
1.79 1.6  1.2   4.11 62.5  70    10393 SFO 6
1.65 1.85 4.25  4.31 65.3  72.75 10423 SFO 7
1.58 1.64 1.84  4.63 65    72.75 10454 SFO 8
1.83 2.01 3.08  5.03 63.1  75.25 10485 SFO 9
1.62 2.14 1.81  4.58 61.4  80.25 10515 SFO 10
1.43 2.02 1.33  4.11 56.5  78    10546 SFO 11
0.9  2.21 8.23  6.33 50.4  74.75 10576 SFO 12
run;