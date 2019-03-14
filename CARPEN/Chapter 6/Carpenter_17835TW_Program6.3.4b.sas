* Program 6.3.4b
* Comparison of the SYMGET and RESOLVE functions;

%let dsn = clinics;
%let clinics = Bethesda;

data demo;
 dname = 'clinics';
 amp   = '&dsn';
 * unquoted arguments;
 a1 = symget(dname);
 a2 = resolve(dname);
 a3 = symget(dsn);
 a4 = resolve(dsn);
 a5 = symget(amp);
 a6 = resolve(amp);
 put / a1= a2= a3= a4= a5= a6=;

 * Using a single quote;
 b1 = symget('dname');
 b2 = resolve('dname');
 b3 = symget('dsn');
 b4 = resolve('dsn');
 b5 = symget('amp');
 b6 = resolve('amp');
 put / b1= b2= b3= b4= b5= b6=;

 * Single quote with &;
 c1 = symget('&dsn');
 c2 = resolve('&dsn');
 c3 = symget('&amp');
 c4 = resolve('&amp');
 put / c1= c2= c3= c4=;

 * Double quote with &;
 d1 = symget("&dsn");
 d2 = resolve("&dsn");
 d3 = symget("&amp");
 d4 = resolve("&amp");
 put / d1= d2= d3= d4=;

 * Quoted triple ampersand;
 e1 = resolve('&&&dsn');
 put / e1= ;
 run;
