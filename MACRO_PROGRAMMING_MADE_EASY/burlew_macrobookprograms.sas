/* libname books "C:\books\datasets"; */--this is the original libname that came up with the code;
libname books '/folders/myfolders/burlewmacro';/*this lib ref is what i gave to link my own folder*/

data books.ytdsales(label='Sales for 2014');
  attrib section   length=$30 label='Section'
         booktitle length=$50 label='Title of Book'
         author    length=$50 label='First Author'
         publisher length=$50 label='Publisher'
         bookfmt   length=$5  label='Book Format'
         cost      length=8 label='Wholesale Cost'
                   format=dollar10.2
         listprice length=8 label='List Price'
                   format=dollar10.2
         saleprice length=8 label='Sale Price'
                   format=dollar10.2
         saleid    length=8 label='Sale ID'
                   format=8.
         datesold  length=4 label='Date Book Sold'
                   format=mmddyy10. informat=mmddyy10. ;

  array sname{6} $ 30 ('Software'
                       'Networking'
                       'Operating Systems'
                       'Programming'
                       'Certification and Training'
                       'Web Development');
  array ln{125} $ 15 _temporary_ (
'Smith     '  'Johnson    ' 'Williams   ' 'Jones      '
'Brown     '  'Davis      ' 'Miller     ' 'Wilson     '
'Moore     '  'Taylor     ' 'Anderson   ' 'Thomas     '
'Jackson   '  'White      ' 'Harris     ' 'Martin     '
'Thompson  '  'Garcia     ' 'Martinez   ' 'Robinson   '
'Clark     '  'Rodriguez  ' 'Lewis      ' 'Lee        '
'Walker    '  'Hall       ' 'Allen      ' 'Young      '
'Hernandez '  'King       ' 'Wright     ' 'Lopez      '
'Hill      '  'Scott      ' 'Green      ' 'Adams      '
'Baker     '  'Gonzalez   ' 'Nelson     ' 'Carter     '
'Mitchell  '  'Perez      ' 'Roberts    ' 'Turner     '
'Phillips  '  'Campbell   ' 'Parker     ' 'Evans      '
'Edwards   '  'Collins    ' 'Stewart    ' 'Sanchez    '
'Morris    '  'Rogers     ' 'Reed       ' 'Cook       '
'Morgan    '  'Bell       ' 'Murphy     ' 'Bailey     '
'Rivera    '  'Cooper     ' 'Richardson ' 'Cox        '
'Howard    '  'Ward       ' 'Torres     ' 'Peterson   '
'Gray      '  'Ramirez    ' 'James      ' 'Watson     '
'Brooks    '  'Kelly      ' 'Sanders    ' 'Price      '
'Bennett   '  'Wood       ' 'Barnes     ' 'Ross       '
'Henderson '  'Coleman    ' 'Jenkins    ' 'Perry      '
'Powell    '  'Long       ' 'Patterson  ' 'Hughes     '
'Flores    '  'Washington ' 'Butler     ' 'Simmons    '
'Foster    '  'Gonzales   ' 'Bryant     ' 'Alexander  '
'Russell   '  'Griffin    ' 'Diaz       ' 'Hayes      '
'Myers     '  'Ford       ' 'Hamilton   ' 'Graham     '
'Sullivan  '  'Wallace    ' 'Woods      ' 'Cole       '
'West      '  'Jordan     ' 'Owens      ' 'Reynolds   '
'Fisher    '  'Ellis      ' 'Harrison   ' 'Gibson     '
'Mcdonald  '  'Cruz       ' 'Marshall   ' 'Ortiz      '
'Gomez     '  'Murray     ' 'Freeman    ' 'Wells      '
'Webb         ');

  array fn{70} $ 11 _temporary_ (
'James      ' 'John       ' 'Robert     ' 'Michael    '
'William    ' 'David      ' 'Richard    ' 'Charles    '
'Joseph     ' 'Thomas     ' 'Christopher' 'Daniel     '
'Paul       ' 'Mark       ' 'Donald     ' 'George     '
'Kenneth    ' 'Steven     ' 'Edward     ' 'Brian      '
'Ronald     ' 'Anthony    ' 'Kevin      ' 'Jason      '
'Matthew    ' 'Gary       ' 'Timothy    ' 'Jose       '
'Larry      ' 'Jeffrey    ' 'Jacob      ' 'Joshua     '
'Ethan      ' 'Andrew     ' 'Nicholas   '
'Mary       ' 'Patricia   ' 'Linda      ' 'Barbara    '
'Elizabeth  ' 'Jennifer   ' 'Maria      ' 'Susan      '
'Margaret   ' 'Dorothy    ' 'Lisa       ' 'Nancy      '
'Karen      ' 'Betty      ' 'Helen      ' 'Sandra     '
'Donna      ' 'Carol      ' 'Ruth       ' 'Sharon     '
'Michelle   ' 'Laura      ' 'Sarah      ' 'Kimberly   '
'Deborah    ' 'Jessica    ' 'Shirley    ' 'Cynthia    '
'Angela     ' 'Melissa    ' 'Emily      ' 'Hannah     '
'Emma       ' 'Ashley     ' 'Abigail    ');


  array pubname{12} $ 30 ('AMZ Publishers'   'Technology Smith'
                   'Mainst Media'      'Nifty New Books'
                   'Wide-World Titles'
                   'Popular Names Publishers' 'Eversons Books'
                   'Professional House Titles'
                   'IT Training Texts' 'Bookstore Brand Titles'
                   'Northern Associates Titles'
                   'Doe&Lee Ltd.');

  array prices{13} p1-p13 (27,30,32,34,36,40,44,45,50,54,56,60,86);
  array smax{6} (850,450,555,890,470,500);

  array momax{12} momax1-momax12
                   (31,28,31,30,31,30,31,31,30,31,30,31);

  keep section booktitle author publisher listprice saleprice cost
       saleid datesold bookfmt;

  retain saleid 10000000;

  call streaminit(12345);

  do i=1 to 6;
    section=sname{i};
    sectionmax=smax{i};
    ntitles=ceil(rand('uniform')*40)+5;
    pval=round(2*rand('normal'),1) + 7;
    if pval > 13 then pval=13;
    else if pval < 1 then pval=1;

    plistprice=prices{pval} + .95;
    psaleprice=plistprice*.85;
    elistprice=round(.7*plistprice,1) + .99;
    esaleprice=elistprice*.85;

    total=0;
    do j=1 to ntitles;
      ncopies=abs(ceil(60*rand('normal')));

      booktitle=catx(' ',section,'Title',put(j,4.));
      lnptr=ceil(rand('uniform')*125);
      fnptr=ceil(rand('uniform')*70);
      author=catx(' ',cats(ln{lnptr},','),fn{fnptr});

      pubptr=ceil(rand('uniform')*12);
      publisher=pubname{pubptr};

      do n=1 to ncopies;
        value=ceil(rand('uniform')*5);
        bookfmt=ifc(value le 3,'paper','ebook');

        if bookfmt='paper' then do;
          listprice=plistprice;
          saleprice=psaleprice;
        end;
        else if bookfmt='ebook' then do;
          listprice=elistprice;
          saleprice=esaleprice;
        end;

        if mod(ntitles,3)=0 then saleprice=saleprice*.9;
        else if mod(ntitles,3)=1 then saleprice=saleprice*.8;
        else if mod(ntitles,4)=0 then saleprice=saleprice*.7;

        saleprice=round(saleprice,.01);

        cost=.4*listprice;
        if mod(ntitles,5)=0 then cost=.5*listprice;

        d=ceil(rand('uniform')*365);
        datesold=datejul(2014000+d);

        saleid+1;
        output;
      end;

      total+ncopies;
      if total gt sectionmax then leave;
    end;
  end;
run;

/*******************************************************/
/* Start Chapter 1                                     */
/*******************************************************/
/**************************/
/* Example 1.1            */
/**************************/
%let month_sold=4;
proc print data=books.ytdsales
                   (where=(month(datesold)=&month_sold));
  title "Books Sold for Month &month_sold";
  var booktitle saleprice;
  sum saleprice;
run;

/**************************/
/* Example 1.2            */
/**************************/
%macro sales;
  %do year=2014 %to 2016;
    proc means data=books.sold&year;
      title "Sales Information for &year";
      class section;
      var listprice saleprice;
    run;
  %end;
%mend sales;
%sales

/************************************************/
/* Example 1.3                                  */
/************************************************/
/* PROC TABULATE step                           */
/************************************************/
%let repmonth=4;
%let repyear=2014;
%let repmword=%sysfunc(mdy(&repmonth,1,&repyear),monname9.);

proc tabulate data=books.ytdsales;
  where month(datesold)=&repmonth and year(datesold)=&repyear;
  title "Sales During &repmword &repyear";
  class section;
  var saleprice listprice cost;
  tables section all='**TOTAL**',
         (saleprice listprice cost)*(n*f=4. sum*f=dollar10.2);
run;


/************************************************/
/* PROC SGPANEL step                            */
/************************************************/
ods graphics on / reset=all;
ods graphics on / imagefmt=png reset=index;

%let repmonth=4;
%let repyear=2014;
%let repmword=%sysfunc(mdy(&repmonth,1,&repyear),monname9.);

proc sgpanel data=books.ytdsales;
  where month(datesold) <= &repmonth and year(datesold)=&repyear;
  title "Sales Through &repmword &repyear";
  panelby section / novarname;
  hbar datesold / stat=sum fill datalabel response=saleprice;
  label datesold='Month of Sale';
  format datesold monname3.;
run;


/************************************************/
/* Revised Example 1.3                          */
/************************************************/
/* Revised PROC TABULATE step                   */
/************************************************/
%let repmonth=5;
%let repyear=2014;
%let repmword=%sysfunc(mdy(&repmonth,1,&repyear),monname9.);

proc tabulate data=books.ytdsales;
  where month(datesold)=&repmonth and year(datesold)=&repyear;
  title "Sales During &repmword &repyear";
  class section;
  var saleprice listprice cost;
  tables section all='**TOTAL**',
         (saleprice listprice cost)*(n*f=4. sum*f=dollar10.2);
run;


/************************************************/
/* Revised PROC SGPANEL step                    */
/************************************************/
ods graphics on / reset=all;

ods graphics on / imagefmt=png reset=index;

%let repmonth=5;
%let repyear=2014;
%let repmword=%sysfunc(mdy(&repmonth,1,&repyear),monname9.);

proc sgpanel data=books.ytdsales;
  where month(datesold) <= &repmonth and year(datesold)=&repyear;
  title "Sales Through &repmword &repyear";
  panelby section / novarname;
  hbar datesold / stat=sum fill datalabel response=saleprice;
  label datesold='Month of Sale';
  format datesold monname3.;
run;


/************************************************/
/* Example 1.4                                  */
/************************************************/
title "Sales Report";
title2 "As of &systime &sysday &sysdate9";
title3 "Using SAS Version: &sysver";
proc means data=books.ytdsales n sum;
  /* Use this WHERE statement to compute the same stats as in the book */
  where datesold le '20feb2014'd;
  var saleprice;
run;

/************************************************/
/* Example 1.5                                  */
/************************************************/
%macro daily;
  proc means data=books.ytdsales maxdec=2 sum;
    where datesold=today();
    title "Daily Sales Report for &sysdate9";
    class section;
    var saleprice;
  run;
  %if &sysday=Friday %then %do;
     proc means data=books.ytdsales maxdec=2 sum;
       /* where today()-6 le datesold le today(); */
       /* Use this WHERE statement to compute the same stats as in the book */
       where '22aug2014'd-6 le datesold le '22aug2014'd;
       title "Weekly Sales Report Week Ending &sysdate9";
       class section;
       var saleprice;
     run;
  %end;
%mend daily;

%daily


/************************************************/
/* Example 1.6                                  */
/************************************************/
%macro makesets;
  data
    %do i=1 %to 12;
      month&i
    %end;
    ;
    set books.ytdsales;
    mosale=month(datesold);
    if mosale=1 then output month1;
    %do i=2 %to 12;
      else if mosale=&i then output month&i;
    %end;
  run;
%mend makesets;

%makesets


/************************************************/
/* Example 1.7                                  */
/************************************************/
data temp;
  set books.ytdsales end=lastobs;
  retain sumsoftprog 0;
  if section in ('Software','Programming') then
    sumsoftprog=sumsoftprog + saleprice;
  if lastobs then
    call symputx('softprogsales',put(sumsoftprog,dollar10.2));
run;

ods graphics on / reset=all;

ods graphics on / imagefmt=png reset=index;

proc sgplot data=temp;
  title "Sales by Section";
  title2 "Software and Programming Combined: &softprogsales";
  hbar section / stat=sum fill datalabel response=saleprice;
  yaxis display=(nolabel noticks);
  format saleprice dollar10.2;
run;

proc sql noprint;
  select sum(saleprice) format=dollar10.2 into :sumsoftprog
    from books.ytdsales
    where section in ('Software','Programming');
quit;


/************************************************/
/* Example 1.8                                  */
/************************************************/
%macro dsreport(dsname);
  %*----Open data set dsname;
  %let dsid=%sysfunc(open(&dsname));

  %*----How many obs are in the data set?;
  %let nobs=%sysfunc(attrn(&dsid,nobs));

  %*----When was the data set created?;
  %let when = %sysfunc(putn(
                 %sysfunc(attrn(&dsid,crdte)),datetime9.));

  %*----Close data set dsname identified by dsid;
  %let rc=%sysfunc(close(&dsid));

  title "Report on Data Set &dsname";
  title2 "Num Obs: &nobs Date Created: &when";

  proc means data=&dsname sum maxdec=2;
    class section;
    var saleprice;
  run;
%mend dsreport;

%dsreport(books.ytdsales)


/************************************************/
/* Example 1.9                                  */
/************************************************/
%macro standardopts;
  options nodate number byline;
  title "Book Sales Report";
  footnote1 "Prepared &sysday &sysdate9 at &systime using SAS &sysver";
%mend standardopts;

/*******************************************************/
/* End Chapter 1                                     */
/*******************************************************/
/*******************************************************/

/*******************************************************/
/*******************************************************/
/* Start Chapter 3                                     */
/*******************************************************/

/************************************************/
/* Example 3.1                                  */
/************************************************/
%let reptitle=Book Section;
%let repvar=section;

title "Frequencies by &reptitle as of &sysday";
proc freq data=books.ytdsales;
  tables &repvar;
run;

/************************************************/
/* Revised Example 3.1                          */
/************************************************/
%let reptitle=Book Section;
%let repvar=section;

title "Frequencies by &reptitle as of &sysday";
proc freq data=books.ytdsales;
 tables &repvar;
run;

title "Means by &reptitle as of &sysday";
proc means data=books.ytdsales;
  class &repvar;
  var saleprice;
run;


/************************************************/
/* Example 3.2                                  */
/************************************************/
%let reptitle=Section;
%let repvar=section;

title "Frequencies by &reptitle as of &sysday";
proc freq data=books.ytdsales;
  /* Add the WHERE statement to produce the same table */
  /* as in Chapter 3                                   */
  where datesold le '02may2014'd;
  tables &repvar;
run;

title 'Means by &reptitle as of &sysday';
proc means data=books.ytdsales sum maxdec=2;
  /* Add the WHERE statement to produce the same table */
  /* as in Chapter 3                                   */
  where datesold le '02may2014'd;
  class &repvar;
  var saleprice;
run;



/************************************************/
/* Example 3.5                                  */
/************************************************/
%let reptitle=Book Section;
%let repvar=section;

%put My macro variable REPTITLE has the value &reptitle;
%put My macro variable REPVAR has the value &repvar;
%put Automatic macro variable SYSDAY has the value &sysday;
%put &=reptitle &=repvar &=sysday;

title "Frequencies by &reptitle as of &sysday";
proc freq data=books.ytdsales;
  tables &repvar;
run;


/************************************************/
/* Example 3.6                                  */
/************************************************/
options symbolgen;

%let reptitle=Book Section;
%let repvar=section;

title "Frequencies by &reptitle as of &sysday";
proc freq data=books.ytdsales;
  tables &repvar;
run;

title "Means by &reptitle as of &sysday";
proc means data=books.ytdsales sum maxdec=2;
  class &repvar;
  var saleprice;
run;


/************************************************/
/* Example 3.7                                  */
/************************************************/
data lastweek;
  set books.ytdsales;
  /* This is the WHERE statement in the book                  */
  where section='Web Development' and datesold > "&sysdate"d-6;
  /* Use the following WHERE statement to reproduce the table */
  /* in the book                                              */
  where section='Web Development' and "16jun14"d le datesold le "22jun14"d;
run;
proc print data=lastweek;
  title "Web Development Titles Sold in the Past Week";
  title2 "Report Date: &sysday &sysdate &systime";
  footnote1 "Data Set Used: &syslast SAS Version: &sysver";

  var booktitle datesold saleprice;
run;


/************************************************/
/* Example 3.8                                  */
/************************************************/
%let nocalc=53*21 + 100.1;
%put &=nocalc;

%let value1=982;
%put &=value1;
%let value2=813;
%put &=value2;
%let result=&value1 + &value2;
%put &=result;

%let reptext=This report is for ***  Department XYZ  ***;
%put &=reptext;

%let region=Region 3;
%put &=region;
%let text=Sales Report;
%put &=text;
%let moretext="Sales Report";
%put &=moretext;
%let reptitle=&text &region;
%put &=reptitle;
%let reptitle2=&moretext &region;
%put &=reptitle2;

%let sentence=      This one started with leading blanks.;
%put Now no leading blanks:&sentence;

%let chars=Symbols: !@#$%^&*;
%put &chars;

%let novalue=;
%put &=novalue;

%let holdvars=varnames;
%put &holdvars;
%let &holdvars=title author datesold;
%put &holdvars;
%put &varnames;


/************************************************/
/* Example 3.9                                  */
/************************************************/
%let mosold=4;
%let level=12;

data book&mosold&level;
  set books.ytdsales(where=(month(datesold)=&mosold));

  attrib over&level length=$3 label="Cost > $&level";

  if cost > &level then over&level='YES';
  else over&level='NO';
run;

proc freq data=book&mosold&level;
title "Frequency Count of Books Sold During Month &mosold";
title2 "Grouped by Cost Over $&level";
  tables over&level;
run;


/************************************************/
/* Example 3.10                                 */
/************************************************/
*----WARNING: This program does not execute;
%let prefix=QUESTION;

proc freq data=books.survey;
  tables &prefix1 &prefix2 &prefix3 &prefix4 &prefix5;
run;
/************************************************/
/* Revised Example 3.10                         */
/************************************************/
*----This program executes correctly;
%let prefix=QUESTION;

proc freq data=books.survey;
  tables &prefix.1 &prefix.2 &prefix.3 &prefix.4 &prefix.5;
run;

/************************************************/
/* Example 3.11                                 */
/************************************************/
*----WARNING: This program does not execute;
%let survlib=BOOKSURV;

proc freq data=&survlib.survey1;
  tables age;
run;
/************************************************/
/* Revised Example 3.11                         */
/************************************************/
*----This program executes;
%let survlib=BOOKSURV;

proc freq data=&survlib..survey1;
  tables age;
run;


/************************************************/
/* Example 3.12                                 */
/************************************************/
%let section1=Certification and Training;
%let section2=Networking;
%let section3=Operating Systems;
%let section4=Programming;
%let section5=Software;
%let section6=Web Development;

*----Look for section number defined by macro var n;
%let n=3;
proc means data=books.ytdsales;
  title "Sales for Section: &&section&n";
  where section="&&section&n";
  var saleprice;
run;

/************************************************/
/* Example 3.13                                 */
/************************************************/
options symbolgen;
%let section3=Operating Systems;
%let n=3;

%put &section&n;
/**************************************************/
/* More sample code in Example 3.12               */
/**************************************************/
options symbolgen;
%let section3=Operating Systems;
%let n=3;

%put &&section&n;

/************************************************/
/* Example 3.14                                 */
/************************************************/
options symbolgen;
%let section1=Certification and Training;
%let section2=Networking;
%let section3=Operating Systems;
%let section4=Programming;
%let section5=Software;
%let section6=Web Development;

%let n=3;
%let wherevar=section;

proc means data=books.ytdsales;
  title "Sales for &wherevar: &&&wherevar&n";
  where &wherevar="&&&wherevar&n";
  var saleprice;
run;

/*******************************************************/
/* End Chapter 3                                       */
/*******************************************************/
/*******************************************************/

/*******************************************************/
/*******************************************************/
/* Start Chapter 4                                     */
/*******************************************************/
/**************************/
/* Example 4.1 and 4.3    */
/**************************/
ods graphics on / reset=all;

ods graphics on / imagefmt=png reset=index;

%macro profitchart;
  ods graphics / maxlegendarea=0;

  title "Profit Report for Week Ending &sysdate9";
  proc sgplot data=temp;
    where today()-6 <=datesold <= today();
    hbar section / response=profit group=section stat=sum datalabel;
    yaxis label=' ';
  run;
%mend profitchart;

data temp;
  set books.ytdsales;
  attrib profit label='Profit' format=dollar8.2;
  profit=saleprice-cost;
run;
%profitchart



/**************************/
/* Example 4.2            */
/**************************/
proc catalog c=work.sasmacr;
  contents;
run;
quit;


/**************************/
/* Example 4.4            */
/**************************/
options mprint mlogic;

%macro listparm(opts,start,stop);
  title "Books Sold by Section Between &start and &stop";
  proc means data=books.ytdsales &opts;
    where "&start"d le datesold le "&stop"d;
    class section;
    var saleprice;
  run;
%mend listparm;


*----First call to LISTPARM, all 3 parameters specified;
%listparm(n sum,01JUN2014,15JUN2014)
*----Second call to LISTPARM, first parameter is null,;
*----second and third parameters specified;
%listparm(,01SEP2014,15SEP2014)



/**************************/
/* Example 4.5            */
/**************************/
%macro keyparm(opts=N SUM MIN MAX,
               start=01JAN2014,stop=31DEC2014);
  title "Books Sold by Section Between &start and &stop";
  proc means data=books.ytdsales &opts;
    where "&start"d le datesold le "&stop"d;
    class section;
    var saleprice;
  run;
%mend keyparm;

*----First call to KEYPARM: specify all keyword parameters;
%keyparm(opts=n sum,start=01JUN2014,stop=15JUN2014)

*----Second call to KEYPARM: specify start and stop,;
*----opts is null: should see default stats for PROC MEANS;
%keyparm(opts=,start=01SEP2014,stop=15SEP2014)

*----Third call to KEYPARM: use defaults for start and stop,; *----specify opts;
%keyparm(opts=n sum)

/**************************/
/* Example 4.6            */
/**************************/
options mprint mlogic;

%macro mixdparm(stats,othropts,
                start=01JAN2014,stop=31DEC2014);
  title "Books Sold by Section Between &start and &stop";
  proc means data=books.ytdsales &stats &othropts;
    where "&start"d le datesold le "&stop"d;
    class section;
    var saleprice;
  run;
%mend mixdparm;

%*----Compute default stats for December 2014 and allow
      missing values to be valid in creating combinations of
      the CLASS variables;
%mixdparm(,missing,start=01DEC2014)

%*----Compute default stats for all of 2014;
%mixdparm()



/**************************/
/* Example 4.6            */
/**************************/
options mprint nomlogic nosymbolgen;

%macro pbuffparms / parmbuff;
  ods graphics on / reset=all;

  %*----Process this section when parameter values specified;
  %if &syspbuff ne %then %do;
    %let i=1;
    %let month=%scan(&syspbuff,&i);
    %do %while(&month ne);
      proc sgplot data=books.ytdsales
                    (where=(month(datesold)=&month));
        title "Section Sales Report for Month &month";
        hbar section / response=saleprice stat=sum
                       datalabel;
        yaxis label=' ';
      run;
      %let i=%eval(&i+1);
      %let month=%scan(&syspbuff,&i);
   %end;
  %end;

  %*----Process this section when no parameter values
        specified;
  %else %do;
    proc sgplot data=books.ytdsales;
      title "Annual Section Sales by Quarter";
      hbar section / response=saleprice stat=sum
                     group=datesold;
      yaxis label=' ';
      label datesold='Quarter';
      format datesold qtr.;
    run;
  %end;

%mend pbuffparms;

*----Analyze sales for August and November;
%pbuffparms(8,11)

*----Analyze sales for entire year;
%pbuffparms()


/*******************************************************/
/* End Chapter 4                                       */
/*******************************************************/
/*******************************************************/


/*******************************************************/
/*******************************************************/
/* Start Chapter 5                                     */
/*******************************************************/
/**************************/
/* Example 5.1            */
/**************************/
options symbolgen mprint;

%let subset=Software;

%macro makeds;
  data temp;
    set books.ytdsales(where=(section="&subset"));
    attrib qtrsold label='Quarter of Sale';
    qtrsold=qtr(datesold);
  run;
%mend makeds;

%makeds

proc tabulate data=temp;
  title "Book Sales Report Produced &sysdate9";
  class qtrsold;
  var saleprice listprice;
  tables qtrsold all,
         (saleprice listprice)*(n*f=6. sum*f=dollar12.2) /
         box="Section: &subset";
  keylabel all='** Total **';
run;


/**************************/
/* Example 5.2            */
/**************************/
options symbolgen mprint;

%macro makeds(subset);
  data temp;
    set books.ytdsales(where=(section="&subset"));
    attrib qtrsold label='Quarter of Sale';
    qtrsold=qtr(datesold);
  run;
%mend makeds;

%makeds(Software)

proc tabulate data=temp;
  title "Book Sales Report Produced &sysdate9";
  class qtrsold;
  var saleprice listprice;
  tables qtrsold all,
         (saleprice listprice)*(n*f=6. sum*f=dollar12.2) /
         box="Section: &subset";
  keylabel all='** Total **';
run;


/**************************/
/* Example 5.3            */
/**************************/
options symbolgen mprint;

%macro makeds(subset);
  data temp;
    set books.ytdsales(where=(section="&subset"));
    attrib qtrsold label='Quarter of Sale';
    qtrsold=qtr(datesold);
  run;

  proc tabulate data=temp;
    title "Book Sales Report Produced &sysdate9";
    class qtrsold;
    var saleprice listprice;

    tables qtrsold all,
           (saleprice listprice)*(n*f=6. sum*f=dollar12.2) /
           box="Section: &subset";
    keylabel all='** Total **';
  run;
%mend makeds;

%makeds(Software)


/**************************/
/* Example 5.4            */
/**************************/
options symbolgen mprint;

%macro makeds(subset);
  %global glbsubset;
  %let glbsubset=&subset;

  data temp;
    set books.ytdsales(where=(section="&subset"));
    attrib qtrsold label='Quarter of Sale';
    qtrsold=qtr(datesold);
  run;
%mend makeds;

%makeds(Software)

proc tabulate data=temp;
  title "Book Sales Report Produced &sysdate9";
  class qtrsold;
  var saleprice listprice;
  tables qtrsold all,
         (saleprice listprice)*(n*f=6. sum*f=dollar12.2) /
         box="Section: &glbsubset";
  keylabel all='** Total **';
run;


/**************************/
/* Example 5.5            */
/**************************/
options symbolgen mprint;

%let subset=Software;

%macro loclmvar;
  %local subset;
  %let subset=Web Development;

  proc means data=books.ytdsales n sum maxdec=2;
    title "Book Sales Report Produced &sysdate9";
    title2 "Uses LOCAL SUBSET macro variable: &subset";
    where section="&subset";
    var saleprice;
  run;
%mend loclmvar;

%loclmvar

proc means data=books.ytdsales n sum maxdec=2;
  title "Book Sales Report Produced &sysdate9";
  title2 "Uses GLOBAL SUBSET macro variable: &subset";
  where section="&subset";
  var saleprice;
run;


/*******************************************************/
/* End Chapter 5                                       */
/*******************************************************/
/*******************************************************/

/*******************************************************/
/*******************************************************/
/* Start Chapter 6                                     */
/*******************************************************/
/**************************/
/* Example 6.1            */
/**************************/
proc means data=books.ytdsales;
  title "Sales for 01%substr(&sysdate,3,3) through &sysdate9";
  where "01%substr(&sysdate,3)"d le datesold le "&sysdate"d;
  class section;
  var saleprice;
run;

/**************************/
/* Example 6.2            */
/**************************/
%let months=January February March April May June;
%let repmonth=3;

proc print data=books.ytdsales;
  title "Sales Report for %scan(&months,&repmonth)";
  where month(datesold)=&repmonth;
  var booktitle author saleprice;
run;

/**************************/
/* Example 6.3            */
/**************************/
%macro listtext(keytext);
  %let keytext=%upcase(&keytext);
  proc print data=books.ytdsales;
  title "Book Titles Sold Containing Text String &keytext";
    where upcase(booktitle) contains "&keytext";
    var booktitle author saleprice;
  run;
%mend;

%listtext(web)

/**************************/
/* Table 6.3              */
/**************************/
%put %eval(33 + 44);
%put %eval(33.2 + 44.1);
%put %sysevalf(33.2 + 44.1);
%put %sysevalf(33.2 + 44.1,integer);
%let a=3;
%let b=10;
%put %eval(&b/&a);
%put %sysevalf(&b/&a);
%put %sysevalf(&b/&a,ceil);
%put %sysevalf(&b/&a,floor);
%put %sysevalf(&b/&a,boolean);
%let missvalue=.;
%put %sysevalf(&b-&missvalue,boolean);


/**************************/
/* Example 6.4            */
/**************************/
%* For example purposes only, ensure these two macro
   variables do not exist in the global symbol table;
%symdel glbsubset subset;

%macro makeds(subset);
  %global glbsubset;
  %let glbsubset=&subset;

   %* What is domain of SUBSET and GLBSUBSET inside MAKEDS?;
   %put ******** Inside macro program;
   %put Is SUBSET a local macro variable(0=No/1=Yes): %symlocal(subset);
   %put Is SUBSET a global macro variable(0=No/1=Yes): %symglobl(subset);
   %put Is GLBSUBSET a local macro variable(0=No/1=Yes): %symlocal(glbsubset);
   %put Is GLBSUBSET a global macro variable(0=No/1=Yes): %symglobl(glbsubset);
   %put ********;


  data temp;
    set books.ytdsales(where=(section="&subset"));
    attrib qtrsold label='Quarter of Sale';
    qtrsold=qtr(datesold);
  run;
%mend makeds;

%makeds(Software)

%* Are SUBSET and GLBSUBSET in global symbol table?;
%put Does SUBSET exist (0=No/1=Yes): %symexist(subset);
%put Is SUBSET a global macro variable(0=No/1=Yes): %symglobl(subset);
%put Is GLBSUBSET a global macro variable(0=No/1=Yes): %symglobl(glbsubset);

proc tabulate data=temp;
  title "Book Sales Report Produced &sysdate9";
  class qtrsold;
  var saleprice listprice;
  tables qtrsold all,
         (saleprice listprice)*(n*f=6. sum*f=dollar12.2) /
         box="Section: &glbsubset";
  keylabel all='** Total **';
run;


/**************************/
/* Example 6.5            */
/**************************/
title
  "Sales for %sysfunc(date(),monname.) %sysfunc(date(),year.)";


/**************************/
/* Example 6.6            */
/**************************/
%macro getopt(whatopt);
  %let optvalue=%sysfunc(getoption(&whatopt));
  %put Option &whatopt = &optvalue;
%mend getopt;

%getopt(number)
%getopt(orientation)
%getopt(date)
%getopt(symbolgen)
%getopt(compress)

/**************************/
/* Example 6.7            */
/**************************/
%macro checkvarname(value);
  %let position=%sysfunc(notname(&value));
  %put **** Invalid character in position: &position (0 means &value is okay);
  %let valid=%sysfunc(nvalid(&value,v7));
  %put
     **** Can &value be a variable name(0=No, 1=Yes)? &valid;
  %put;
  %put;
%mend checkvarname;

%checkvarname(valid_name)
%checkvarname( valid_name)
%checkvarname(invalid name)
%checkvarname(book_sales_results_for_past_five_years!)


/*****************************************/
/* Example 6.8 First group of statements */
/*****************************************/
%let a=1.5;
%let b=-2.0;
%let c=1.978;
%let d=-3.5;
%let meanstat=%sysfunc(mean(&a,&b,&c,&d));
%put ****** The mean of &a, &b, &c, and &d is &meanstat..;

/******************************************/
/* Example 6.8 Second group of statements */
/******************************************/
%let a=1.5;
%let b=-2.0;
%let c=1.978;
%let d=-3.5;
%let meanstat=%sysevalf( (&a+&b+&c+&d)/4);
%put ****** The mean of &a, &b, &c, and &d is &meanstat..;


/**************************/
/* Example 6.9            */
/**************************/
%let dsname=books.ytdsales;
%let dsid=%sysfunc(open(&dsname));
%let lastupdate=%sysfunc(attrn(&dsid,modte));
%let rc=%sysfunc(close(&dsid));

proc report data=books.ytdsales nowd;
  title "Publisher List Report &sysdate9";
  title2 "Last Update of &dsname: %sysfunc(putn(&lastupdate,datetime.))";

  column publisher saleprice;
  define publisher / group;
  define saleprice / format=dollar11.2;
  rbreak after / summarize;
run;



/******************************************/
/* Example 6.10 First group of statements */
/******************************************/
%macro checksurvey(response);
  %let validresponses=123459ABCDEZ;
  %let result=%verify(%upcase(&response),&validresponses);
  %put ******* Response &response is valid/invalid (0=valid 1=invalid): &result;
%mend checksurvey;

%checksurvey(f)
%checksurvey(a)
%checksurvey(6)

/*******************************************/
/* Example 6.10 Second group of statements */
/*******************************************/
%macro checksurvey(response);
  %let validresponses=123459ABCDEZ;
  %let result=%sysfunc(verify(%sysfunc(upcase(&response)),&validresponses));
  %put ******* Response &response is valid/invalid (0=valid 1=invalid): &result;
%mend checksurvey;

%checksurvey(f)
%checksurvey(a)
%checksurvey(6)


/*******************************************************/
/* End Chapter 6                                       */
/*******************************************************/
/*******************************************************/



/*******************************************************/
/*******************************************************/
/* Start Chapter 7                                     */
/*******************************************************/
/**************************/
/* Example 7.1            */
/**************************/
%macro comp2vars(value1,value2);
  %put COMPARISON 1:;
  %if &value1 ne &value2 %then
    %put &value1 is not equal to &value2..;
  %else %put &value1 equals &value2..;

  %put COMPARISON 2:;
  %if &value1 > &value2 %then
    %put &value1 is greater than &value2..;
  %else %if &value1 < &value2 %then
    %put &value1 is less than &value2..;
  %else %put &value1 equals &value2..;

  %put COMPARISON 3:;
  %let result=%eval(&value1 > &value2);
  %if &result=1 %then
    %put EVAL result of &value1 > &value2 is TRUE.;
  %else %put EVAL result of &value1 > &value2 is FALSE.;

  %put COMPARISON 4:;
  %let result=%sysevalf(&value1 > &value2);
  %if &result=1 %then
    %put SYSEVALF result of &value1 > &value2 is TRUE.;
  %else %put SYSEVALF result of &value1 > &value2 is FALSE.;

%mend comp2vars;

*----First call to COMP2VARS;
%comp2vars(3,4)

*----Second call to COMP2VARS;
%comp2vars(3.0,3)

*----Third call to COMP2VARS;
%comp2vars(X,x)


/**************************/
/* Example 7.2            */
/**************************/
%macro reports(reptype,repmonth);
  %let lblmonth=
    %sysfunc(mdy(&repmonth,1,%substr(&sysdate,6,2)),monname.);

  %*----Begin summary report section;
  %if %upcase(&reptype)=SUMMARY %then %do;
    %*----Do summary report for report month;
    proc tabulate data=books.ytdsales;
      title "Sales for &lblmonth";
      where month(datesold)=&repmonth;
      class section;
      var listprice saleprice;
      tables section,
        (listprice saleprice)*(n*f=6. sum*f=dollar12.2);
    run;
    %*----If end of quarter, also do summary report for qtr;
    %if &repmonth=3 or &repmonth=6 or &repmonth=9
        or &repmonth=12 %then %do;
      %let qtrstart=%eval(&repmonth-2);

      %let strtmo=
     %sysfunc(mdy(&qtrstart,1,%substr(&sysdate,6,2)),monname.);

      proc tabulate data=books.ytdsales;
        title "Sales for Quarter from &strtmo to &lblmonth";
        where &qtrstart le month(datesold) le &repmonth;
        class section;
        var listprice saleprice;
        tables section,
          (listprice saleprice)*(n*f=6. sum*f=dollar12.2);
      run;
     %end;
  %end;
  %*----End summary report section;
  %*----Begin detail report section;
  %else %if %upcase(&reptype)=DETAIL %then %do;
    %*----Do detail report for month;
    proc print data=books.ytdsales;
      where month(datesold)=&repmonth;
      var booktitle cost listprice saleprice;
      sum cost listprice saleprice;
    run;
  %end;
  %*----End detail report section;
%mend reports;

*----First call to REPORTS does a Summary report for September;
%reports(Summary,9)

*----Second call to REPORTS does a Detail report for October;
%reports(Detail,10)


/**************************/
/* Example 7.3            */
/**************************/
%macro publisherreport(reptype);
  %let reptype=%upcase(&reptype);

  title "Publisher Report";
  footnote
    "Macro Program: &sysmacroname  Report Type: &reptype";

  proc report data=books.ytdsales nowd;
    column publisher saleprice cost profit
      %if &reptype=DETAIL %then %do;
        n
      %end;
      %else %if &reptype=QUARTER %then %do;
          datesold,(saleprice=saleprice2)
      %end;
     ;

    define publisher / group;
    define saleprice / analysis sum format=dollar11.2;

    define cost / analysis sum format=dollar11.2
                  %if &reptype=BASIC %then %do;
                    noprint
                  %end;
                  ;
    define profit / computed format=dollar11.2 'Profit';

    %if &reptype=DETAIL %then %do;
      define n / 'Number of Titles Sold' width=6;
    %end;
    %else %if &reptype=QUARTER %then %do;
      define saleprice2 / 'Quarter Sale Price Total';
      define datesold / across ' ' format=qtr.;
    %end;

    compute profit;
      profit=saleprice.sum-cost.sum;
    endcomp;

    rbreak after / summarize;
    compute after;
      publisher='Total for All Publishers';
    endcomp;

  run;
%mend publisherreport;

%* First call to PUBLISHERREPORT, do BASIC report;
%publisherreport(basic)

%* Second call to PUBLISHERREPORT, do DETAIL report;
%publisherreport(detail)

%* Third call to PUBLISHERREPORT, do QUARTER report;
%publisherreport(quarter)


/**************************/
/* Example 7.4            */
/**************************/
options minoperator;
%macro vendortitles(publisher) / mindelimiter='!';
  title "Vendor-Publisher Report";
  %if &publisher in
           AMZ Publishers!Eversons Books!IT Training Texts
        %then %do;
    title2 "Vendor for &publisher is Baker";
  %end;
  %else %if &publisher in
          Northern Associates Titles!Professional House Titles
              %then %do;
    title2 "Vendor for &publisher is Mediasuppliers";
  %end;
  %else %do;
    title2 "Vendor for &publisher is Basic Distributor";
  %end;
%mend vendortitles;

%vendortitles(AMZ Publishers)

%vendortitles(Mainst Media)


/**************************/
/* Example 7.5            */
/**************************/
%macro multrep(startyear,stopyear);
  %do yrvalue=&startyear %to &stopyear;
    title "Sales Report for &yrvalue";
    proc tabulate data=sales.year&yrvalue;
      class section;
      var cost listprice saleprice;
      tables section all='Total',
             (cost listprice saleprice)*
                 (n*f=6. (min max sum)*f=dollar8.2);
    run;

    proc sgplot data= sales.year&yrvalue;
      hbar section / response=saleprice stat=sum datalabel;
      yaxis display=(nolabel noticks);
    run;
  %end;
%mend multrep;

*----Produce 3 sets of reports: one for 2011, one for 2012,
*----and one for 2013;
%multrep(2011,2013)


/**************************/
/* Example 7.6            */
/**************************/
%macro sumyears(startyear,stopyear);
  data manyyears;
    set
    %do yearvalue=&startyear %to &stopyear;
      sales.year&yearvalue
    %end;
    ;
  run;

  %let yearstring=;
  %do yearvalue=&startyear %to &stopyear;
    %let yearstring=&yearstring &yearvalue;
  %end;

  proc sgplot data=manyyears;
    title "Charts Analyze Data for: &yearstring";
    hbar section / response=saleprice stat=sum datalabel;
    yaxis display=(nolabel noticks);
  run;
%mend sumyears;

*----Concatenate three data sets: one from 2011, one from;
*----2012, and one from 2013;
%sumyears(2011,2013)


/**************************/
/* Example 7.7            */
/**************************/
%macro mosales / parmbuff;
  %let listindex=1;
  %do %until (%scan(&syspbuff,&listindex) eq );
    %let repmonth=%scan(&syspbuff,&listindex);
    proc means data=books.ytdsales n sum maxdec=0;
      %if &repmonth ne %then %do;
        title "Sales during month &repmonth";
        where month(datesold)=&repmonth;
      %end;
      %else %do;
        title "Overall Sales";
      %end;
      class section;
      var saleprice;
    run;
    %let listindex=%eval(&listindex+1);
  %end;
%mend;
*----First call to MOSALES: produce stats for March, May, and
*----October;
%mosales(3 5 10)

*----Second call to MOSALES: produce overall stats;
%mosales()


/**************************/
/* Example 7.8            */
/**************************/
%macro moyrsales(yearlist,repmonth);
  %let yearidx=1;
  %do %while (%scan(&yearlist,&yearidx) ne );
    %let saleyear=%scan(&yearlist,&yearidx);
    proc means data=sales.year&saleyear n sum maxdec=0;
      title "Sales during &repmonth/&saleyear";
      where month(datesold)=&repmonth;
      class section;
      var saleprice;
    run;
    %let yearidx=%eval(&yearidx+1);
  %end;
%mend moyrsales;

%moyrsales(2011 2013,5)


/**************************/
/* Example 7.9            */
/**************************/
%macro detail(dsname,varlist,numobs=max);
  %* Does DSNAME exist?;
  %let foundit=%sysfunc(exist(&dsname));
  %if &foundit le 0 %then %goto nodataset;

  title "PROC PRINT of &dsname";
  proc print data=&dsname(obs=&numobs);
    var &varlist;
  run;
  %goto finished;


  %nodataset:
    %put ERROR: **** Data set &dsname not found. ****;
    %put;
    %* Find the data set libref. If it is not;
    %* specified, assume a temporary data set;
    %* and assign WORK to DSLIBREF;
    %let period=%index(&dsname,.);
    %if &period gt 0 %then
       %let dslibref=%scan(&dsname,1,.);
    %else %let dslibref=work;
    proc datasets library=&dslibref details;
    run;
    quit;

  %finished:
%mend detail;

*----First call to DETAIL, data set exists;
%detail(books.ytdsales,datesold booktitle saleprice,obs=5)

*----Second call to DETAIL, data set does not exist;
%detail(books.ytdsaless,datesold booktitle saleprice)

%*----Third call to DETAIL, look for data set in WORK library;
%detail(ytdsales,datesold booktitle saleprice)

/*******************************************************/
/* End Chapter 7                                       */
/*******************************************************/
/*******************************************************/

/*******************************************************/
/*******************************************************/
/* Start Chapter 8                                     */
/*******************************************************/
/**************************/
/* Example 8.1            */
/**************************/
%let mysqlstep=proc sql;title "SAS Files in Library BOOKS";select memname, memtype from dictionary.members where libname='BOOKS';quit;
%put WITHOUT Quoting Functions MYSQLSTEP=&mysqlstep;

%let mysqlstep=%str(proc sql;title "SAS Files in Library BOOKS";select memname, memtype from dictionary.members where libname='BOOKS';quit;);
%put WITH Quoting Functions MYSQLSTEP=&mysqlstep;

/**************************/
/* Example 8.2            */
/**************************/
%let month=%substr(Jan,Feb,Mar,5,3);
%put WITHOUT Quoting Functions &=month;

%let month=%substr(%str(Jan,Feb,Mar),5,3);
%put WITH Quoting Functions &=month;

/**************************/
/* Example 8.3            */
/**************************/
%let titletext=   B  o  o  k   S  a  l  e  s ;
%put WITHOUT Quoting TITLETEXT=*&titletext*;

%let titletext=%str(   B  o  o  k   S  a  l  e  s );
%put WITH Quoting TITLETEXT=*&titletext*;

/**************************/
/* Example 8.4            */
/**************************/
%let reporttitle=Jan&Feb %Sales Report;
%put WITHOUT Quoting Functions &=reporttitle;

%let reporttitle=%nrstr(Jan&Feb %Sales Report);
%put WITH Quoting Functions &=reporttitle;


/******************************************/
/* Example 8.5 First group of statements  */
/******************************************/
%let names=O'DONOVAN,O'HARA,O'MALLEY;
%let name3=%qscan(&names,3);
%put WITHOUT STR and Percent Signs &=names;
%put WITHOUT STR Quoting Function &=name3;
%let names=%str(O%'DONOVAN,O%'HARA,O%'MALLEY);
%let name3=%qscan(&names,3);
%put WITH STR and Percent Signs &=names;
%put WITH STR Quoting Function &=name3;


/**************************/
/* Example 8.6            */
/**************************/
%let names=%nrstr(O%'DONOVAN&O%'HARA&O%'MALLEY);
%let name3=%qscan(&names,3);
%put WITH NRSTR Quoting Function &=names;
%put WITH NRSTR Quoting Function NAME 3 is: &name3;

/**************************/
/* Example 8.7            */
/**************************/
%let state=OR;
%let value=%sysevalf(&state eq OR, boolean);
%put WITHOUT Quoting Functions &=value;
%let value=%sysevalf( %bquote(&state) eq %str(OR), boolean);
%put WITH Quoting Functions &=value;

/**************************/
/* Example 8.8            */
/**************************/
proc means data=books.ytdsales
            (where=(publisher='Doe&Lee Ltd.')) noprint;
  var saleprice;
  output out=salesdl sum=;
run;

data _null_;
  set salesdl;
  call symputx('totsales_dl',
          cat('The total sales for Doe&Lee Ltd is ',
              put(saleprice,dollar10.2),'.'));
run;
footnote "%superq(totsales_dl)";

/**************************/
/* Example 8.9            */
/**************************/
%macro mosectdetail(monthlist,section);
  proc print data=books.ytdsales;
    title "List of titles sold for months &monthlist";
    where month(datesold) in (&monthlist)
          and section="&section";
    var booktitle saleprice;
  run;
%mend mosectdetail;

%mosectdetail(3,6,Software)

%mosectdetail(%str(3,6),Software)

/**************************/
/* Example 8.10           */
/**************************/
%macro publishersales(style,styleheader,stylereport);
  ods html style=&style;

  title "Sales by Publisher";
  proc report data=books.ytdsales
              style(header)={&styleheader}
              style(report)={&stylereport}
              nowd;
    column publisher saleprice n;
    define publisher / group;
    define saleprice / format=dollar10.2;
  run;

  ods html close;

%mend publishersales;

%publishersales(meadow,
       %str(font_style=italic font_size=14pt font=(Garamond)),
       %str(font_size=12pt))


/**************************/
/* Example 8.11           */
/**************************/
%macro mypages(titletext=,jtitle=center,ctitle=black,
               footnotetext=,jfootnote=right,cfootnote=black);

  %if %superq(titletext)= %then %do;
    title1;
  %end;
  %else %do;
    title justify=&jtitle color=&ctitle
          "&titletext";
  %end;

  %if %superq(footnotetext)= %then %do;
    footnote1;
  %end;
  %else %do;
    footnote justify=&jfootnote color=&cfootnote
             "&footnotetext";
  %end;
%mend mypages;

options macrogen;

*----First call of MYPAGES;
%mypages(titletext=Sales Report,ctitle=blue,
         footnotetext=Last Review Date: Feb 1%str(,) 2014)

*----Second call of MYPAGES;
%mypages(titletext=2013+ Sales,
         footnotetext=Prepared with SAS &sysver)

*----Third call of MYPAGES;
%mypages(titletext=Sales Report,
         footnotetext=Last Reviewed by %str(O%'Malley))

*----Fourth call of MYPAGES;
%mypages(titletext=%nrstr(Audited&Approved),
         footnotetext=
           %nrstr(%Increase in Sales for Year was 8%%),
         jfootnote=center)


/**************************/
/* Example 8.12           */
/**************************/
%macro mar;
  This is March
%mend;

%let m=%nrstr(%mar);
title "Macro call &m generates the following text";
title2 "%unquote(&m)";


/**************************/
/* Example 8.13           */
/**************************/
%let publisher=Doe and Lee;
%let publisher2=%sysfunc(tranwrd(&publisher,and,&));
%let publisher3=%sysfunc(compress(&publisher2)) Ltd.;
%put PUBLISHER3 defined with %nrstr(%SYSFUNC): &publisher3;

%let publisher3=%qsysfunc(compress(&publisher2)) Ltd.;
%put PUBLISHER3 defined with %nrstr(%QSYSFUNC): &publisher3;


/**************************/
/* Example 8.14           */
/**************************/
%let months=%nrstr(Jan&Feb&Mar);
%let month3=%substr(&months,8);
%put Unquoted: &month3;

%let qmonth3=%qsubstr(&months,8);
%put Quoted: &qmonth3;


/*******************************************************/
/* End Chapter 8                                       */
/*******************************************************/
/*******************************************************/


/*******************************************************/
/*******************************************************/
/* Start Chapter 9                                     */
/*******************************************************/
/**************************/
/* Example 9.1            */
/**************************/
%let certific=CRT283817;
%let networki=NET3UD697;
%let operatin=OPSI18375;
%let programm=PRG8361WQ;
%let software=SFT3521P8;
%let webdevel=WBD188377;

data temp;
  set books.ytdsales;

  attrib compsect length=$8 label='Section'
         sectionid length=$9 label='Section ID';

  *----Construct macro variable name by compressing
       section name and taking the first 8 characters.
       e.g. section=Programming, then COMPSECT="Programm";

  compsect=substr(compress(section),1,8);
  sectionid=symget(compsect);
run;
proc print data=temp(obs=15);
  title "Defining the Section Identification Code";
  var section compsect sectionid;
run;


/**************************/
/* Example 9.2            */
/**************************/
%let webfctr=1.20;
%let sftfctr=1.35;

data temp;
  set books.ytdsales(where=(
     section in ('Web Development', 'Software')));
  if section='Web Development' then
                       costfctr=input(symget('webfctr'),best8.);
  else if section='Software' then costfctr=input(symget('sftfctr'),best8.);
  newprice=costfctr*cost;
run;
proc print data=temp(obs=5);
  title "Prices based on COSTFCTR";
  var booktitle section cost costfctr newprice;
  format newprice dollar8.2;
run;

/**************************/
/* Example 9.3            */
/**************************/
%let managerquarter1=LPL;
%let managerquarter2=EMB;
%let managerquarter3=EMB;
%let managerquarter4=ADL;

data managers;
  set books.ytdsales;

  length managerinits $ 3;

  managerinits=
     symget(cats('managerquarter',put(qtr(datesold),1.)));
run;
proc print data=managers(obs=8);
  title "Sale Dates and Managers";
  var datesold managerinits;
run;


/**************************/
/* Example 9.4            */
/**************************/
data _null_;
  set books.ytdsales end=eof;
  if saleprice ge 30 then nhigh+1;
  if eof then call symput('n30',put(nhigh,comma.));
run;
proc means data=books.ytdsales n mean min max sum maxdec=2;
  title "All Books Sold";
  title2 "Number of Books Sold for More Than $30: &n30";
  var saleprice;
run;


/**************************/
/* Example 9.5            */
/**************************/
data newbooks;
  input booktitle $ 1-40;
  call symputx('lasttitle',booktitle);
datalines;
Hello Java Programming
My Encyclopedia of Networks
Strategic Computer Programming
Everyday Email Etiquette
run;
%put The value of macro variable LASTTITLE is &lasttitle..;



/**************************/
/* Example 9.6            */
/**************************/
proc freq data=books.ytdsales noprint;
   tables section / out=sectname;
run;
data _null_;
  set sectname;
  call symputx(cats('name',put(_n_,1.)),section);
  call symputx(cats('n',put(_n_,1.)),count);
run;

%put _user_;


/*****************************************/
/* Example 9.7 First group of statements */
/*****************************************/
%macro statsection(section);
  proc means data=books.ytdsales noprint;
    where section="&section";
    var saleprice;
    output out=sectionresults mean=avgsaleprice
             min=minsaleprice max=maxsaleprice;
  run;

  data _null_;
    set sectionresults;

    call symputx('average',put(avgsaleprice,dollar8.2),'G');
    call symputx('min',put(minsaleprice,dollar8.2),'G');
    call symputx('max',put(maxsaleprice,dollar8.2),'G');
  run;

  %* Submit this statement to see the variables stored in the
     STATSECTION local symbol table;
  %put _local_;
%mend;

%statsection(Software)

title "Section Results for Average Sale Price: &average";
title2 "Minimum Sale Price: &min";
title3 "Maximum Sale Price: &max";

/******************************************/
/* Example 9.7 Second group of statements */
/******************************************/
%macro statsection(section);
  proc means data=books.ytdsales noprint;
    where section="&section";
    var saleprice;
    output out=sectionresults mean=avgsaleprice
             min=minsaleprice max=maxsaleprice;
  run;

  data _null_;
    set sectionresults;

    call symputx('average',put(avgsaleprice,dollar8.2));
    call symputx('min',put(minsaleprice,dollar8.2));
    call symputx('max',put(maxsaleprice,dollar8.2));
  run;

  %* Submit this statement to see the variables stored in the
     STATSECTION local symbol table;
  %put _local_;
%mend;

%symdel average min max;

%statsection(Software)

title "Section Results for Average Sale Price: &average";
title2 "Minimum Sale Price: &min";
title3 "Maximum Sale Price: &max";


/**************************/
/* Example 9.8            */
/**************************/
%macro listautomatic;
  %put **** Start list of automatic macro variables;
  %put _automatic_;
  %put **** End list of automatic macro variables;
%mend listautomatic;

data _null_;
  call execute('%listautomatic');
run;


/**************************/
/* Example 9.9            */
/**************************/
%macro listlibrary;
  %put **** This macro statement in LISTLIBRARY precedes the PROC step code.;
  proc datasets library=books;
  run;
  quit;
  %put **** This macro statement in LISTLIBRARY follows the PROC step code.;
%mend listlibrary;

data _null_;
  put "This SAS language statement precedes the macro program call.";
  call execute('%listlibrary');
  put "This SAS language statement follows the macro program call.";
run;


/**************************/
/* Example 9.10           */
/**************************/
options mprint;

%macro rep16k(section);
  proc report data=books.ytdsales nowd;
    where section="&section";
    title "Sales > $16,000 Summary for &section";
    column  publisher n saleprice;
    define  publisher / group;
    define  n / "Number of Books Sold" ;
    define  saleprice / sum format=dollar10.2 "Sale Price" ;
    rbreak after / summarize;
    compute after;
      publisher="**Total";
    endcomp;
  run;
%mend rep16k;

options mprint;

proc means data=books.ytdsales nway noprint;
  class section;
  var saleprice;
  output out=sectsale sum=totlsale;
run;

data _null_;
  set sectsale;

  if totlsale > 16000 then
    call execute(cats('%rep16k(',section,')'));
run;

/**************************/
/* Example 9.11           */
/**************************/
options nomprint;

%macro highreport(section);
   proc report data=books.ytdsales nowd;
     where section="&section";
     title "Sales > $20,000 Report for Section &section";
     column  publisher n saleprice;
     define  publisher / group;
     define  n / "Number of Books Sold" ;
     define  saleprice / sum format=dollar10.2 "Sale Price" ;
     rbreak after / summarize;
     compute after;
       publisher="**Total";
     endcomp;
  run;
%mend highreport;

%macro lowreport(section);
   proc report data=books.ytdsales nowd;
     where section="&section";
     title "Sales < $12,000 Report for Section &section";
     column datesold n saleprice;
     define datesold / group format=monname15. "Month Sold"
                       style(column)=[just=left];
     define n / "Number of Books Sold";
     define saleprice / sum format=dollar10.2 "Sales Total";
     rbreak after / summarize;
   run;
%mend lowreport;

proc means data=books.ytdsales nway noprint;
  class section;
  var saleprice;
  output out=sectsale sum=totlsect;
run;

data _null_;
  set sectsale;
  if totlsect < 12000 then
    call execute(cats('%lowreport(',section,')'));

  else if totlsect > 20000 then
    call execute(cats('%highreport(',section,')'));
run;


/**************************/
/* Example 9.12           */
/**************************/
%let quartersale1=Holiday Clearance;
%let quartersale2=2 for the Price of 1;
%let quartersale3=Back to School;
%let quartersale4=New Releases;

data temp;
  set books.ytdsales;
  length quartersalename $ 30;

  quarter=qtr(datesold);
  quartersalename=resolve(
       cats('&quartersale',put(quarter,1.)) );
run;
proc freq data=temp;
  title 'Quarter by Quarter Sale Name';
  tables quarter*quartersalename / list nocum nopct;
run;


/**************************/
/* Example 9.13           */
/**************************/
%macro getsalename(quarter);
  %if &quarter=1 %then %do;
    Holiday Clearance
  %end;
  %else %if &quarter=2 %then %do;
    2 for the Price of 1
  %end;
  %else %if &quarter=3 %then %do;
    Back to School
  %end;
  %else %if &quarter=4 %then %do;
    New Releases
  %end;
%mend getsalename;

proc means data=books.ytdsales noprint nway;
  class datesold;
  var saleprice;
  output out=quarterly sum=;
  format datesold qtr.;
run;

data quarterly;
  set quarterly(keep=datesold saleprice);

  length quartersalename $ 30;

  quartersalename=resolve( cats('%getsalename(',put(datesold,qtr.),')') );
run;
proc print data=quarterly label;
  title 'Quarter Sales with Quarter Sale Name';
  label datesold='Quarter'
        saleprice='Total Sales'
        quartersalename='Sale Name';
run;



/******************************************/
/* Example 9.14 First group of statements */
/******************************************/
%let findpublisher=Technology Smith;
proc sql noprint;
  select sum(saleprice) format=dollar10.2,
         count(saleprice)
    into :totsales, :nsold
    from books.ytdsales
    where publisher="&findpublisher";
quit;
%put &findpublisher Total Sales=&totsales;
%put &findpublisher Total Number Sold=&nsold;

/*******************************************/
/* Example 9.14 Second group of statements */
/*******************************************/
%let findpublisher=Technology Smith;
proc sql noprint;
  select sum(saleprice) format=dollar10.2,
         count(saleprice)
    into :totsales trimmed, :nsold trimmed
    from books.ytdsales
    where publisher="&findpublisher";
quit;
%put &findpublisher Total Sales=&totsales;
%put &findpublisher Total Number Sold=&nsold;



/**************************/
/* Example 9.15           */
/**************************/
proc sort data=books.ytdsales out=datesorted;
  by datesold;
run;
proc sql noprint;
  select datesold,booktitle,saleprice
    into :firstdate,:firsttitle,:firstprice trimmed
    from datesorted;
quit;

%put One of the first books sold was on &firstdate;
%put The title of this book is &firsttitle;
%put The sale price was &firstprice;

proc print data=datesorted(obs=5);
  title
   'First Five Observations of Sorted by Date BOOKS.YTDSALES';
run;



/**************************/
/* Example 9.16           */
/**************************/
proc sql noprint;
  select section, sum(saleprice) format=dollar10.2
  into :section1 - :section6,
       :sale1 - :sale6  from books.ytdsales
  group by section;
quit;
%put *** 1: &section1 &sale1;
%put *** 2: &section2 &sale2;
%put *** 3: &section3 &sale3;
%put *** 4: &section4 &sale4;
%put *** 5: &section5 &sale5;
%put *** 6: &section6 &sale6;


/**************************/
/* Example 9.17           */
/**************************/
proc sql noprint;
  select unique(section)
  into :allsect separated by '/'
  from books.ytdsales
  order by section;
quit;
%put The value of macro variable ALLSECT is &allsect;


/**************************/
/* Example 9.18           */
/**************************/
%let listlib=BOOKS;
proc sql noprint;
  select memname
  into :datasetnames separated by ' '
  from dictionary.tables
  where libname="&listlib";
quit;
%put The datasets in library &listlib is(are) &datasetnames;


/******************************************/
/* Example 9.19 First group of statements */
/******************************************/
options mprint;

%macro listsqlpub;
  options symbolgen;
  proc sql noprint;
    select unique(publisher)
      into :pub1 -
    from books.ytdsales;
  quit;
  options nosymbolgen;

  %put Total number of publishers: &sqlobs..;
  %do i=1 %to &sqlobs;
    %put Publisher &i: &&pub&i;
  %end;
%mend listsqlpub;

%listsqlpub

/*******************************************/
/* Example 9.19 Second group of statements */
/*******************************************/
options mprint;

%macro listsqlpub;
  options symbolgen;
  proc sql noprint;
    select unique(publisher)
      into :pub1 - :pub2
    from books.ytdsales;
  quit;
  options nosymbolgen;

  %put Total number of publishers: &sqlobs..;
  %do i=1 %to &sqlobs;
    %put Publisher &i: &&pub&i;
  %end;
%mend listsqlpub;

%listsqlpub

/*******************************************/
/* Example 9.19 Third group of statements  */
/*******************************************/
options mprint;

%macro listsqlpub;
  options symbolgen;
  proc sql noprint;
    select unique(publisher)
      into :pub1 - :pub100
    from books.ytdsales;
  quit;
  options nosymbolgen;

  %put Total number of publishers: &sqlobs..;
  %do i=1 %to &sqlobs;
    %put Publisher &i: &&pub&i;
  %end;
%mend listsqlpub;

%listsqlpub

%put &pub13;


/******************************************/
/* Example 9.20 First group of statements */
/******************************************/
proc sql;
  select * from dictionary.options
  where group='MACRO';
quit;

/*******************************************/
/* Example 9.20 Second group of statements */
/*******************************************/
options mindelimiter='#';
proc sql noprint;
  select setting
  into :mysetting
  from dictionary.options
  where optname='MINDELIMITER';
quit;
%put My current MINDELIMITER setting is &mysetting;

/*******************************************/
/* Example 9.20 Third group of statements  */
/*******************************************/
%let mysetting=%sysfunc(getoption(mindelimiter));


/**************************/
/* Example 9.21           */
/**************************/
proc sql;
  select * from dictionary.macros;
quit;

/*******************************************************/
/* End Chapter 9                                       */
/*******************************************************/
/*******************************************************/


/*******************************************************/
/*******************************************************/
/* Start Chapter 10                                     */
/*******************************************************/
/**************************/
/* Example 10.1           */
/**************************/
libname myapps 'c:\mymacroprograms';
options mstored sasmstore=myapps;

%macro reptitle(repprog) / store des='Standard Report Titles';
  title "Bookstore Report &repprog";
  title2 "Processing Date: &sysdate  SAS Version: &sysver";
%mend reptitle;


/**************************/
/* Example 10.2           */
/**************************/
libname myapps 'c:\mymacroprograms';
options mstored sasmstore=myapps;

%macro reptitle(repprog) / store source
                           des='Standard Report Titles';
  title "Bookstore Report &repprog";
  title2 "Processing Date: &sysdate  SAS Version: &sysver";
%mend reptitle;

%copy reptitle / library=myapps source;
%copy reptitle / library=myapps source
             outfile='c:\mymacroprograms\reptitle_source.sas';

/*******************************************************/
/* End Chapter 10                                      */
/*******************************************************/
/*******************************************************/

/*******************************************************/
/*******************************************************/
/* Start Chapter 11                                    */
/*******************************************************/
/*******************************************/
/* Example 11.1 First group of statements  */
/*******************************************/
%macro listsample(dsname);
  %if %sysfunc(exist(&dsname)) %then %do;
    proc print data=&dsname(obs=10);
     title "First 10 Observations of &dsname";
    run;
  %end;
  %else  %put ERROR: ***** Data set &dsname does not exist.;
%mend listsample;

%listsample(books.ytdsales)

/********************************************/
/* Example 11.1 Second group of statements  */
/********************************************/
%macro multcond(dsname);
  %local rc dsid exist nlobs readpw;

  %*----Initialize return code to 1;
  %let rc=1;
  %*----Initialize data set id;
  %let dsid=0;

  %*----Does data set exist (condition 1);
  %let exist=%sysfunc(exist(&dsname));
  %*----Data set does not exist;
  %if &exist=0 %then %goto setrc;

  %let dsid=%sysfunc(open(&dsname,i));
  %*----Data set cannot be opened (condition 2);
  %if &dsid le 0 %then %goto setrc;
  %*----Any obs to list from this data set? (condition 3);
  %let nlobs=%sysfunc(attrn(&dsid,nlobs));
  %*----No obs to list;
  %if &nlobs le 0 %then %goto setrc;

  %*----Read password set on this data set? (condition 4);
  %let readpw=%sysfunc(attrn(&dsid,readpw));
  %*----READPW in effect, do not list;
  %if &readpw=1 %then %goto setrc;

  %*----Data set okay to list, skip over section
        that sets RC to 0;
  %goto exit;

  %*----Problems with data set, set RC to 0;
  %setrc:
  %let rc=0;

  %exit:
  %if &dsid ne %then %let closerc=%sysfunc(close(&dsid));

  %*----Return the value of macro variable RC;
  %sysfunc(putn(&rc,1.))
%mend;

%macro listsample(dsname);
  %if %multcond(&dsname)=1 %then %do;
    proc print data=&dsname(obs=10);
      title "First 10 Observations of &dsname";
    run;
  %end;
  %else  %put ERROR: ***** Data set &dsname cannot be listed.;
%mend listsample;

*----First call to LISTSAMPLE;
%listsample(books.ytdsales)

*----Second call to LISTSAMPLE;
%listsample(books.ytdsaless)


/**************************/
/* Example 11.2           */
/**************************/
%macro trimname(namevalue);
  %cmpres(%qupcase(%sysfunc(
      compress(%superq(namevalue),%str(, ),kA))))
%mend trimname;

proc tabulate data=books.ytdsales
   (where=(upcase(author)=
         "%trimname(%str(wright,   LINDA))"))
       ;
  title "Title list for %trimname(%str(wright, linda))";
  class booktitle datesold bookfmt;
  tables booktitle=' ',
         datesold="Quarter Sold" all='**Total Books Sold',
         all="Books Sold"*(bookfmt all='Total')*n=' '*f=3. / misstext='0';
  format datesold qtr.;
run;


/**************************/
/* Example 11.3           */
/**************************/
%macro rtf_start(style=,orientation=);
  %* This macro program initializes settings to send reports
     to ODS RTF destination;

  options orientation=&orientation nodate;
  ods rtf style=&style;

  title1 justify=center "Bookstore";
  footnote justify=right "Report Prepared &sysdate9";
%mend rtf_start;

%macro rtf_end;
 %* This macro program resets options and closes the RTF
    destination after sending a report to the ODS RTF
    destination;

  ods rtf close;
  ods html;

  options orientation=portrait date;
  title;
  footnote1;
%mend rtf_end;

%rtf_start(style=money,orientation=landscape)

proc report data=books.ytdsales nowd;
  column section saleprice;
  define section / group;
  define saleprice / sum analysis format=dollar11.2;
  rbreak after / summarize;
  compute after;
    section='** Totals **';
  endcomp;
run;

%rtf_end


/**************************/
/* Example 11.4           */
/**************************/
%macro facts(dsname);
  %local dslib dsmem varpos varalpha dslabel crdate modate
         nobs nvar;
  %let dsname=%upcase(&dsname);

  %*----Extract each part of data set name;
  %let dslib=%scan(&dsname,1,.);
  %let dsmem=%scan(&dsname,2,.);

  proc sql noprint;
    create table npos as
      select npos,name
      from dictionary.columns
      where libname="&dslib" and memname="&dsmem"
       order by npos;
    select name into :varpos separated by ', ' from npos;

    select name
      into :varalpha separated by ', '
      from dictionary.columns
      where libname="&dslib" and memname="&dsmem"
      order by name;

    select memlabel,crdate,modate,nobs,nvar
      into :dslabel,:crdate,:modate,:nobs,:nvar
      from dictionary.tables
      where libname="&dslib" and memname="&dsmem";
  quit;

  data temp;
    length attribute $ 35
           value $ 500;

    *----Create an observation for each characteristic of the
         data set;
    attribute='Creation Date and Time';
    value="&crdate";
    output;
    attribute='Last Modification Date and Time';
    value="&modate";
    output;
    attribute='Number of Observations';
    value="&nobs";
    output;
    attribute='Number of Variables';
    value="&nvar";
    output;
    attribute='Variables by Position';
    value="&varpos";
    output;
    attribute='Variables Alphabetically';
    value="&varalpha";
    output;
  run;

  ods pdf style=statistical;
  title "Data Set Report for &dsname %trim(&dslabel)";
  proc print data=temp noobs label;
    var attribute value;
    label attribute='Attribute'
          value='Value';
  run;
  proc print data=&dsname(obs=5);
    title2 "First 5 Observations";
  run;
  ods pdf close;

  proc datasets library=work nolist;
    delete temp npos;
  run;
  quit;
%mend facts;

%facts(books.ytdsales)

/*******************************************************/
/* End Chapter 11                                      */
/*******************************************************/
/*******************************************************/


/*******************************************************/
/*******************************************************/
/* Start Chapter 12                                    */
/*******************************************************/
/**************************/
/* Example 12.1           */
/**************************/
options noserror symbolgen;
%macro print10(dsname);
  proc print data=&dsname(obs=10);
    title "Listing First 10 Observations from &dsnamee";
  run;
%mend;
%print10(books.ytdsales)
options serror nosymbolgen;

/*********************************/
/* Example 12.2 Does not execute */
/*********************************/
%macro whstmt(getsection,getpub);
  %if &getsection ne or &getpub ne %then %do;
    (where=((
  %end;
  %if &getsection ne %then %do;
    section="&getsection"
    %if &getpub ne %then %do;
      and
    %end;
    %else %do;
      )))
    %end;
  %end;
  %if &getpub ne %then %do;
    publisher="&getpub")))
  %end
%mend whstmt;
data temp;
  set books.ytdsales
    %whstmt(Software,AMZ Publishers)
  ;
run;

/*********************************/
/* Example 12.2 Executes         */
/*********************************/
%macro whstmt(getsection,getpub);
  %if &getsection ne or &getpub ne %then %do;
    (where=((
  %end;
  %if &getsection ne %then %do;
    section="&getsection"
    %if &getpub ne %then %do;
      and
    %end;
    %else %do;
      )))
    %end;
  %end;
  %if &getpub ne %then %do;
    publisher="&getpub")))
  %end;
%mend whstmt;
data temp;
  set books.ytdsales
    %whstmt(Software,AMZ Publishers)
  ;
run;


/*********************************/
/* Example 12.3 Does not execute */
/*********************************/
options mlogic;

%macro markup(publisher,rate1,rate2,rate3);
  %let diffrate=&rate3-&rate1;

  data pubmarkup;
    set books.ytdsales(where=(publisher="&publisher"));

    %if &diffrate ge 5.00 %then %do;
      retain rateplus '+++';
    %end;
    %else %if &diffrate lt 5.00 and &diffrate ge 0.00 %then %do;
      retain rateplus '+';
    %end;
    %else %do;
      retain rateplus '-';
    %end;

    %do i=1 %to 3;
      cost&i=cost* (1+(&&rate&i/100));
    %end;
  run;
%mend markup;

%markup(Technology Smith,2.25,4,7.25)

options nomlogic;

/******************************************************/
/* Example 12.3 Executes but not with expected result */
/******************************************************/
%macro markup(publisher,rate1,rate2,rate3);
  %let diffrate=%sysevalf(&rate3-&rate1);

  data pubmarkup;
    set books.ytdsales(where=(publisher="&publisher"));

    %if &diffrate ge 5.00 %then %do;
      retain rateplus '+++';
    %end;
    %else %if &diffrate lt 5.00 and &diffrate ge 0.00 %then %do;
      retain rateplus '+';
    %end;
    %else %do;
      retain rateplus '-';
    %end;

    %do i=1 %to 3;
      cost&i=cost* (1+(&&rate&i/100));
    %end;
  run;
%mend markup;

%markup(Technology Smith,2.25,4,7.25)

/******************************************************/
/* Example 12.3 Executes correctly                    */
/******************************************************/
options mlogic;

%macro markup(publisher,rate1,rate2,rate3);
  %let diffrate=%sysevalf(&rate3-&rate1);

  data pubmarkup;
    set books.ytdsales(where=(publisher="&publisher"));

    %if %sysevalf(&diffrate ge 5.00) %then %do;
      retain rateplus '+++';
    %end;
    %else %if %sysevalf(&diffrate lt 5.00) and
           %sysevalf(&diffrate ge 0.00) %then %do;
      retain rateplus '+';
    %end;
    %else %do;
      retain rateplus '-';
    %end;

    %do i=1 %to 3;
      cost&i=cost* (1+(&&rate&i/100));
    %end;
  run;
%mend markup;

%markup(Technology Smith,2.25,4,7.25)

options nomlogic;



/**************************************/
/* Example 12.4 Executes indefinitely */
/**************************************/
options mprint;

%macro tables(class_string);
  class datesold &class_string;
  %let varnum=1;
  %let classvar=%scan(&class_string,&varnum);

  %do %until (&classvar=' ');
    tables datesold='Books Sold Quarter'
           all='Books Sold All Four Quarters',
           (&classvar all),
           (cost listprice saleprice)*sum=' '*f=dollar12.2 ;

    %let varnum=%eval(&varnum+1);
    %let classvar=%scan(&class_string,&varnum);

    %put **** VARNUM=&varnum   CLASSVAR=&classvar;
  %end;
%mend tables;

proc tabulate data=books.ytdsales;
  title "Quarterly Book Sales Summaries";
  var cost listprice saleprice;
  format datesold qtr.;
  keylabel all='Total';

  %tables(section publisher)
run;

options nomprint;

/*************************************/
/* Example 12.4 Executes correctly   */
/*************************************/
%macro tables(class_string);
  class datesold &class_string;
  %let varnum=1;
  %do %until (&classvar=);
    %let classvar=%scan(&class_string,&varnum);
    tables datesold='Books Sold Quarter'
           all='Books Sold All Four Quarters',
           (&classvar all),
           (cost listprice saleprice)*sum=' '*f=dollar12.2 ;

    %let varnum=%eval(&varnum+1);
    %let classvar=%scan(&class_string,&varnum);
  %end;
%mend tables;

proc tabulate data=books.ytdsales;
  title "Quarterly Book Sales Summaries";
  var cost listprice saleprice;
  format datesold qtr.;
  keylabel all='Total';

  %tables(section publisher)
run;



/**************************************/
/* Example 12.5 Executes incorrectly  */
/**************************************/
options mlogic;
%macro extfiles(publisher,rtf=,spreadsheet=) / minoperator;
  %let rtf=%upcase(&rtf);
  %let spreadsheet=%upcase(&spreadsheet);

  data temp;
    set books.ytdsales(where=(publisher="&publisher"));
    lostprofit=listprice-saleprice;
  run;

  %if &rtf in Y YES %then %do;
    %makertf
  %end;
  %else %if &spreadsheet in Y YES %then %do;
    %makespreadsheet
  %end;
%mend extfiles;

%macro makertf;
  ods rtf style=meadow;
  proc print data=temp(drop=saleid publisher);
    title "Publisher: &publisher";
    format saleprice listprice;
  run;
  ods rtf close;
%mend makertf;

%macro makespreadsheet;
  proc export data=temp(where=(bookfmt='ebook'))
              file="pubreports.xlsx"
              replace;
              sheet="Ebook &publisher";
  run;
  proc export data=temp(where=(bookfmt='paper'))
              file="pubreports.xlsx"
              replace;
              sheet="Paper &publisher";
  run;
%mend makespreadsheet;

%extfiles(Eversons Books,rtf=Y,spreadsheet=Y)

options nomlogic;

/**************************************/
/* Example 12.5 Executes correctly    */
/**************************************/
options mlogic;
%macro extfiles(publisher,rtf=,spreadsheet=) / minoperator;
  %let rtf=%upcase(&rtf);
  %let spreadsheet=%upcase(&spreadsheet);

  data temp;
    set books.ytdsales(where=(publisher="&publisher"));
    lostprofit=listprice-saleprice;
  run;

  %if &rtf in Y YES %then %do;
    %makertf
  %end;
  %if &spreadsheet in Y YES %then %do;
    %makespreadsheet
  %end;
%mend extfiles;

%macro makertf;
  ods rtf style=meadow;
  proc print data=temp(drop=saleid publisher);
    title "Publisher: &publisher";
    format saleprice listprice;
  run;
  ods rtf close;
%mend makertf;

%macro makespreadsheet;
  proc export data=temp(where=(bookfmt='ebook'))
              file="pubreports.xlsx"
              replace;
              sheet="Ebook &publisher";
  run;
  proc export data=temp(where=(bookfmt='paper'))
              file="pubreports.xlsx"
              replace;
              sheet="Paper &publisher";
  run;
%mend makespreadsheet;

%extfiles(Eversons Books,rtf=Y,spreadsheet=Y)

options nomlogic;


/**************************************/
/* Example 12.6 Executes incorrectly  */
/**************************************/
options mprint;
%macro projcost(analysisvars);
  proc tabulate data=projcost;
    title "Projected Costs Report";
    class section;
    var &analysisvars;
    tables section all='All Sections',
           &analysisvars*(mean*f=dollar7.2 sum*f=dollar12.2);
  run;
%mend projcost;

data projcost;
  set books.ytdsales;

  array increase{5} increase2014-increase2018
      (1.12,1.08,1.10,1.15,1.18);
  array pcost{5} pcost2014-pcost2018;
  drop i;

  attrib pcost2014 label="Projected Cost 2014" format=dollar10.2
         pcost2015 label="Projected Cost 2015" format=dollar10.2
         pcost2016 label="Projected Cost 2016" format=dollar10.2
         pcost2017 label="Projected Cost 2017" format=dollar10.2
         pcost2018 label="Projected Cost 2018" format=dollar10.2;

  do i=1 to 5;
    pcost{i}=round(cost*increase{i},.01);
  end;
run;

%projcost(cost pcost2014 pcost2016)

options nomprint;

/**************************************/
/* Example 12.6 Executes correctly    */
/**************************************/
%macro projcost(analysisvars);
  proc tabulate data=projcost;
    title "Projected Costs Report";
    class section;
    var &analysisvars;
    tables section all='All Sections',
           (&analysisvars)*(mean*f=dollar7.2 sum*f=dollar12.2);
  run;
%mend projcost;

data projcost;
  set books.ytdsales;

  array increase{5} increase2014-increase2018
      (1.12,1.08,1.10,1.15,1.18);
  array pcost{5} pcost2014-pcost2018;
  drop i;

  attrib pcost2014 label="Projected Cost 2014" format=dollar10.2
         pcost2015 label="Projected Cost 2015" format=dollar10.2
         pcost2016 label="Projected Cost 2016" format=dollar10.2
         pcost2017 label="Projected Cost 2017" format=dollar10.2
         pcost2018 label="Projected Cost 2018" format=dollar10.2;

  do i=1 to 5;
    pcost{i}=round(cost*increase{i},.01);
  end;
run;

%projcost(cost pcost2014 pcost2016)


/*******************/
/* Example 12.7    */
/*******************/
%macro selecttitles(monthsold=,minsaleprice=,publisher=);
  %* All three parameters must be specified.;
  %* Quote the value of PUBLISHER in case it contains special
     characters or mnemonic operators;
  %if &monthsold= or &minsaleprice= or %superq(publisher)= %then %do;
    %put ******************************************************;
    %put * Macro program SELECTTITLES requires you to specify all;
    %put * three parameters. At least one was not specified:;
    %put * MONTHSOLD=&monthsold;
    %put * MINSALEPRICE=&minsaleprice;
    %put * PUBLISHER=&publisher;
    %put * Please correct and resubmit.;
    %put *****************************************************;
    %goto exit;
  %end;

  %* Check if parameters are valid;
  %* MONTHSOLD must be numeric and 1 to 12;
  %if %sysfunc(notdigit(&monthsold)) gt 0 or
        &monthsold lt 1 or &monthsold gt 12 %then %do;
    %put *****************************************************;
    %put ERROR: MONTHSOLD was not specified correctly: &monthsold;
    %put ERROR- Specify MONTHSOLD as an integer from 1 to 12;
    %put *****************************************************;
    %goto exit;
  %end;

  %* MINSALEPRICE must be numeric greater than 0 and if dollar
     signs and commas included, remove them;
  %let minsaleprice=%sysfunc(compress (&minsaleprice,%str(,)$));
  %if %sysfunc(notdigit(%sysfunc(compress(&minsaleprice,.)))) gt 0 %then %do;
    %put *****************************************************;
    %put ERROR: MINSALEPRICE was not specified correctly: &minsaleprice;
    %put *****************************************************;
    %goto exit;
  %end;

  %* Uppercase value of PUBLISHER and remove multiple blanks.
     Use quoting functions since value might contain special
     characters or mnemonic operators;
  %let publisher=%qupcase(%superq(publisher));
  %let publisher=%qcmpres(%superq(publisher));

  proc print data=books.ytdsales(where=
                 (month(datesold)=&monthsold and
                  saleprice ge &minsaleprice and
                  upcase(publisher)="&publisher"))
                 noobs n="Number of Books Sold=";
    title "Titles Sold during Month %sysfunc(putn(&monthsold,monname.))";
    title2 "Minimum Sale Price of $&minsaleprice";
    title3 "Publisher &publisher";
  run;

%exit:
%mend selecttitles;

%selecttitles(monthsold=2,minsaleprice=$20.95,
              publisher=%nrstr(Doe&Lee   Ltd.))


/*******************/
/* Example 12.8    */
/*******************/
%macro lastmsg;

  %* Check last warning message;
  %put;
  %if %bquote(&syswarningtext) eq %then
      %put No warnings generated so far in this SAS session;
  %else %do;
    %put Last warning message generated in this SAS session:;
    %put &syswarningtext;
  %end;

  %put;
  %* Check last error message;
  %if %bquote(&syserrortext) eq %then
    %put No error messages generated so far in this SAS session;
  %else %do;
    %put Last error message generated in this SAS session:;
    %put &syserrortext;
    %put;
  %end;
  %put;
%mend lastmsg;

ods rtf style=bookstore;


proc freq data=books.ytdsales;
  tables datesoldd;
  format datesold monname.;
run;

data profit;
  set boooks.ytdsales;

  profit=saleprice-cost;
run;

ods rtf close;

%lastmsg

/*******************/
/* Example 12.9    */
/*******************/
%macro authorreport(author);
  %* Quote the value of AUTHOR in case it contains special
     characters or mnemonic operators;
  %let author=%qupcase(&author);

  data author;
    set books.ytdsales(where=(upcase(author)="&author"));
  run;
  proc sql noprint;
    select count(booktitle)
      into :nbooks
      from author;
  quit;
  %if &nbooks=0 %then %do;
    %put *****************************************************;
    %put ERROR: Author &author not found in data set BOOKS.YTDSALES;
    %put ERROR- No report produced.;
    %put *****************************************************;
  %end;
  %else %if &nbooks=1 %then %do;
    proc print data=author label noobs;
      title "Book Sold for Author &author";
      var booktitle datesold cost saleprice;
      format datesold monname.;
    run;
  %end;
  %if &nbooks gt 1 %then %do;
    proc tabulate data=author;
      title "Books Sold for Author &author";
      class section datesold booktitle;
      var cost saleprice;
      tables section*datesold*booktitle all='Total',
             n*f=4. (cost saleprice)*sum='Total'*f=dollar10.2;
      format datesold monname.;
    run;
  %end;
%mend authorreport;

/* This author is not in data set */
%authorreport(%str(Allan, Michael))

/* This author sold one book */
%authorreport(%str(Henderson, Jeffrey))

/* This author sold more than one book */
%authorreport(%str(Gonzales, Angela))

/*******************************************************/
/* End Chapter 12                                      */
/*******************************************************/
/*******************************************************/

/*******************************************************/
/*******************************************************/
/* Start Chapter 13                                    */
/*******************************************************/

/*******************/
/* Report A Step 1 */
/*******************/
title "Sales Report";
title2 "July 1, 2014 - August 31, 2014";
data temp;
  set books.ytdsales(where=
                ('01jul2014'd le datesold le '31aug2014'd));
  profit=saleprice-cost;

  attrib profit label='Profit' format=dollar11.2;
run;

proc tabulate data=temp;
  var cost listprice saleprice profit;
  tables n*f=6.
         (cost listprice saleprice profit)*
          sum='Total'*f=dollar11.2;
  keylabel n='Titles Sold';
run;


/*******************/
/* Report B Step 1 */
/*******************/
ods graphics on / reset=all;

ods graphics on / imagefmt=png reset=index;

title "Sales Report";
title2 "January 1, 2014 - March 31, 2014";
data temp;
  set books.ytdsales(where=
                 ('01jan2014'd le datesold le '31mar2014'd));

  profit=saleprice-cost;

  attrib profit label='Profit' format=dollar11.2;
run;
proc sql;
  select name,label from dictionary.columns
    where libname='WORK' and memname='TEMP' and
          (upcase(name)='SALEPRICE' or upcase(name)='PROFIT');
  select sum(saleprice) as saleprice_sum format=dollar11.2,
         sum(profit) as profit_sum format=dollar11.2
    from temp;
quit;

proc tabulate data=temp;
  class section;
  var saleprice profit;
  tables section all,
    n*f=6. (saleprice profit)*sum='Total'*f=dollar11.2;
  keylabel all='Total Sales'
           n='Titles Sold';
run;
proc sgplot data=temp;
  title3 "Total Sale Price for Time Period: $22,854.27";
  hbar section / stat=sum response=saleprice datalabel;
  xaxis labelattrs=(weight=bold);
  yaxis label=' ' valueattrs=(weight=bold);
run;
proc sgplot data=temp;
  title3 "Total Profit for Time Period: $11,262.01";
  hbar section / stat=sum response=profit datalabel;
  xaxis labelattrs=(weight=bold);
  yaxis label=' ' valueattrs=(weight=bold);
run;



/*******************/
/* Report C Step 1 */
/*******************/

ods rtf file='C:\books\output13_3.rtf'
         style=statistical;

title "Sales Report";
title2 "January 1, 2014 - November 24, 2014";
data temp;
  set books.ytdsales(where=
             ('01jan2014'd le datesold le '24nov2014'd));

  profit=saleprice-cost;
  attrib profit label='Profit' format=dollar11.2;

run;

proc tabulate data=temp;
  class section publisher;
  var cost profit;
  tables section*(publisher all) all,
    n*f=6. (cost profit)*sum*f=dollar11.2;
  keylabel all='Total Sales'
           n='Titles Sold';
run;

ods rtf close;



/*******************/
/* Report A Step 2 */
/*******************/
%let repyear=2014;
%let start=01jul&repyear;
%let stop=31aug&repyear;
%let vars=cost listprice saleprice profit;

%let titlestart=%sysfunc(putn("&start"d,worddate.));
%let titlestop=%sysfunc(putn("&stop"d,worddate.));

options symbolgen;

title "Sales Report";
title2 "&titlestart - &titlestop";
data temp;
  set books.ytdsales(where=
      ("&start"d le datesold le "&stop"d));

  profit=saleprice-cost;

  attrib profit label='Profit' format=dollar10.2;
run;

proc tabulate data=temp;
  var &vars;
  tables n*f=6.
         (&vars)*
          sum='Total'*f=dollar11.2;
  keylabel n='Titles Sold';
run;

options nosymbolgen;

/*******************/
/* Report B Step 2 */
/*******************/
%let repyear=2014;
%let start=01jan&repyear;
%let stop=31mar&repyear;

%let classvar=section;
%let vars=saleprice profit;

%let titlestart=%sysfunc(putn("&start"d,worddate.));
%let titlestop=%sysfunc(putn("&stop"d,worddate.));

options symbolgen;

title "Sales Report";
title2 "&titlestart - &titlestop";
data temp;
  set books.ytdsales(where=
      ("&start"d le datesold le "&stop"d));

  profit=saleprice-cost;

  attrib profit label='Profit' format=dollar11.2;
run;
proc sql noprint;
  select sum(%scan(&vars,1)) format=dollar11.2 into :%scan(&vars,1)_sum
    from temp;
  select label into :%scan(&vars,1)_label trimmed
    from dictionary.columns
    where libname='WORK' and memname='TEMP' and
          upcase(name)="%upcase(%scan(&vars,1))";
  select sum(%scan(&vars,2)) format=dollar11.2 into :%scan(&vars,2)_sum
    from temp;
  select label into :%scan(&vars,2)_label trimmed
    from dictionary.columns
    where libname='WORK' and memname='TEMP' and
          upcase(name)="%upcase(%scan(&vars,2))";

quit;
proc tabulate data=temp;
  class &classvar;
  var &vars;
  tables section all
    n*f=6. (&vars)*sum='Total'*f=dollar11.2;
  keylabel all='Total Sales'
           n='Titles Sold';
run;

proc sgplot data=temp;
  title3 "Total &&%scan(&vars,1)_label for Time Period: &&%scan(&vars,1)_sum";
  hbar &classvar / stat=sum response=%scan(&vars,1) datalabel;
  xaxis labelattrs=(weight=bold);
  yaxis label=' ' valueattrs=(weight=bold);
run;
proc sgplot data=temp;
  title3 "Total &&%scan(&vars,2)_label for Time Period: &&%scan(&vars,2)_sum";
  hbar &classvar / stat=sum response=%scan(&vars,1) datalabel;
  xaxis labelattrs=(weight=bold);
  yaxis label=' ' valueattrs=(weight=bold);
run;

options nosymbolgen;

/*******************/
/* Report C Step 2 */
/*******************/
%let repyear=2014;
%let start=01jan&repyear;

/* Uncomment this if you want to run this as of today */
%*let stop=&sysdate9;

/* The book assumes "today" is 27NOV2014 */
%let stop=27nov&repyear;

%let classvar=section publisher;
%let vars=cost profit;

%let titlestart=%sysfunc(putn("&start"d,worddate.));
%let titlestop=%sysfunc(putn("&stop"d,worddate.));

%let outputdest=rtf;
%let outputstyle=statistical;

options symbolgen;

ods &outputdest style=&outputstyle;

title "Sales Report";
title2 "&titlestart - &titlestop";
data temp;
  set books.ytdsales(where=
      ("&start"d le datesold le "&stop"d));

  profit=saleprice-cost;
  attrib profit label='Profit' format=dollar11.2;

run;

proc tabulate data=temp;
  class &classvar;
  var &vars;
  tables %scan(&classvar,1)*(%scan(&classvar,2) all) all,
    n*f=6. (&vars)*sum*f=dollar11.2;
  keylabel all='Total Sales'
           n='Titles Sold';
run;

ods &outputdest close;

/*******************/
/* Report A Step 3 */
/*******************/
%macro reporta(repyear=,start=01JAN,stop=31DEC,
               vars=cost listprice saleprice profit);

  %let start=&start&repyear;
  %let stop=&stop&repyear;

  %let titlestart=%sysfunc(putn("&start"d,worddate.));
  %let titlestop=%sysfunc(putn("&stop"d,worddate.));

  title "Sales Report";
  title2 "&titlestart - &titlestop";
  data temp;
    set books.ytdsales(where=
        ("&start"d le datesold le "&stop"d));

    profit=saleprice-cost;

    attrib profit label='Profit' format=dollar10.2;
  run;

  proc tabulate data=temp;
    var &vars;
    tables n*f=6.
           (&vars)*
            sum='Total'*f=dollar11.2;
    keylabel n='Titles Sold';
  run;
%mend reporta;

%reporta(repyear=2014,start=01jul,stop=31aug)

/*******************/
/* Report B Step 3 */
/*******************/
%macro reportb(repyear=,start=01JAN,stop=31DEC,
               classvar=,vars=);

  %let start=&start&repyear;
  %let stop=&stop&repyear;

  %let titlestart=%sysfunc(putn("&start"d,worddate.));
  %let titlestop=%sysfunc(putn("&stop"d,worddate.));

  title "Sales Report";
  title2 "&titlestart - &titlestop";
  data temp;
    set books.ytdsales(where=
        ("&start"d le datesold le "&stop"d));

    profit=saleprice-cost;

    attrib profit label='Profit' format=dollar11.2;
  run;
  proc sql noprint;
    select sum(%scan(&vars,1)) format=dollar11.2 into :%scan(&vars,1)_sum
      from temp;
    select label into :%scan(&vars,1)_label trimmed
      from dictionary.columns
      where libname='WORK' and memname='TEMP' and
            upcase(name)="%upcase(%scan(&vars,1))";
    select sum(%scan(&vars,2)) format=dollar11.2 into :%scan(&vars,2)_sum
      from temp;
    select label into :%scan(&vars,2)_label trimmed
      from dictionary.columns
      where libname='WORK' and memname='TEMP' and
            upcase(name)="%upcase(%scan(&vars,2))";

  quit;
  proc tabulate data=temp;
    class &classvar;
    var &vars;
    tables section all,
      n*f=6. (&vars)*sum='Total'*f=dollar11.2;
    keylabel all='Total Sales'
             n='Titles Sold';
  run;

  proc sgplot data=temp;
    title3 "Total &&%scan(&vars,1)_label for Time Period: &&%scan(&vars,1)_sum";
    hbar &classvar / stat=sum response=%scan(&vars,1) datalabel;
    xaxis labelattrs=(weight=bold);
    yaxis label=' ' valueattrs=(weight=bold);
  run;
  proc sgplot data=temp;
    title3 "Total &&%scan(&vars,2)_label for Time Period: &&%scan(&vars,2)_sum";
    hbar &classvar / stat=sum response=%scan(&vars,1) datalabel;
    xaxis labelattrs=(weight=bold);
    yaxis label=' ' valueattrs=(weight=bold);
  run;

%mend reportb;

%reportb(repyear=2014,stop=31Mar,classvar=section,
         vars=saleprice profit)

/*******************/
/* Report C Step 3 */
/*******************/
%macro reportc(repyear=,start=01JAN,stop=31DEC,
               classvar=,vars=,
               outputdest=,style=);

  %let start=&start&repyear;
  %let stop=&stop&repyear;

  %let classvar=section;
  %let vars=saleprice profit;

  %let titlestart=%sysfunc(putn("&start"d,worddate.));
  %let titlestop=%sysfunc(putn("&stop"d,worddate.));

  %let outputdest=rtf;
  %let outputstyle=statistical;

  ods &outputdest style=&outputstyle;

  title "Sales Report";
  title2 "&titlestart - &titlestop";
  data temp;
    set books.ytdsales(where=
        ("&start"d le datesold le "&stop"d));

    profit=saleprice-cost;
    attrib profit label='Profit' format=dollar11.2;

  run;

  proc tabulate data=temp;
    class section publisher;
    var cost profit;
    tables section*(publisher all) all,
      n*f=6. (cost profit)*sum*f=dollar11.2;
    keylabel all='Total Sales'
             n='Titles Sold';
  run;

  ods &outputdest close;

%mend reportc;

%reportc(repyear=2014,stop=24NOV,classvar=section publisher,
         vars=cost profit,outputdest=rtf,style=statistical)



/*******************************/
/* Report Macro Program Step 4 */
/*******************************/
options mprint mlogic;

%macro report(repyear=,startddmmm=01JAN,stopddmmm=31DEC,
              classvar=,vars=cost listprice saleprice profit,
              outputdest=html,style=) / minoperator;

  %*----Check if a value was specified for report year.
        If no value specified,use current year;
  %if &repyear= %then %let repyear=%substr(&sysdate9,6);
  %*----Check if stop date specified. If null, use
        current date as stop date;
  %if &stopddmmm= %then %let stopddmmm=%substr(&sysdate,1,5);

  %let startddmmm=%upcase(&startddmmm);
  %let stopddmmm=%upcase(&stopddmmm);
  %let start=&startddmmm&repyear;
  %let stop=&stopddmmm&repyear;

  %let titlestart=%sysfunc(putn("&start"d,worddate.));
  %let titlestop=%sysfunc(putn("&stop"d,worddate.));

  %*----Determine number of classification variables;
  %if &classvar ne %then
          %let nclassvars=%sysfunc(countw(&classvar));
  %else %let nclassvars=0;

  %*----Close default destination and open OUTPUTDEST;
  %*----Add STYLE if specified;
  ods &outputdest
    %if &style ne %then %do;
      style=&style
    %end;
    ;

  title "Sales Report";
  title2 "&titlestart - &titlestop";
  data temp;
    set books.ytdsales(where=
       ("&start"d le datesold le "&stop"d));

    profit=saleprice-cost;

    attrib profit label='Profit' format=dollar10.2;
  run;

  proc tabulate data=temp;
    %*----Only submit a CLASS statement if there is a
         classification variable;
    %if &classvar ne %then %do;
       class &classvar;
    %end;
    var &vars;
    tables
      %if &classvar ne %then %do;
        %*---Determine leftmost row dimension variable;
        %scan(&classvar,1)
        %if &nclassvars ge 2 %then %do;
          %*----If more than one classification variable, nest
                remaining classification variables under the
                first.;
          %*----Use the substring function to extract
                classification variables after the first;
          %let pos2=%index(&classvar,%scan(&classvar,2));
          %*----Add the rest of the classification vars;
          * ( %substr(&classvar,&pos2) all)

        %end;
        all,
      %end;
      n*f=6. (&vars)*sum*f=dollar11.2;
      keylabel all='Total Sales'
               n='Titles Sold';
  run;

  %*----Check if date range is for quarter(s) or year;
  %if &startddmmm # 01JAN 01APR 01JUL 01OCT and
      &stopddmmm # 31MAR 30JUN 30SEP 31DEC and
      &startddmmm ne &stopddmmm %then %do;

    %*----Specific title text for Quarter(s) and for Year;
    %if &startddmmm=01JAN and &stopddmmm=31DEC
           %then %let timeperiod=Year;
    %else %let timeperiod=Quarter(s);

    %let nvars=%sysfunc(countw(&vars));
    %do c=1 %to &nclassvars;
      %let classvarname=%scan(&classvar,&c);
      %do v=1 %to &nvars;
        %let varname=%scan(&vars,&v);
        proc sql noprint;
          select sum(&varname) format=dollar11.2 into :&varname._sum
            from temp;
          select label into :&varname._label trimmed
            from dictionary.columns
            where libname='WORK' and memname='TEMP' and
                upcase(name)="%upcase(&varname)";
        quit;
        proc sgplot data=temp;
          title3 "Total &&&varname._label for &timeperiod: &&&varname._sum";
          hbar &classvarname / stat=sum response=&varname datalabel;
          xaxis labelattrs=(weight=bold);
          yaxis label=' ' valueattrs=(weight=bold);
        run;
      %end;
    %end;
  %end;

  %*----Close report output. Open default destination;
  ods &outputdest close;
  ods html;

%mend report;

%report(repyear=2014,startddmmm=01jul,stopddmmm=31aug)

%report(repyear=2014,stopddmmm=31Mar,classvar=section,
         vars=saleprice profit)

%report(stopddmmm=,
        classvar=section publisher,
        vars=cost profit,
        outputdest=rtf,style=statistical)


/*******************************************************/
/* End Chapter 13                                      */
/*******************************************************/
/*******************************************************/


/*******************************************************/
/*******************************************************/
/* Start Appendix A                                    */
/*******************************************************/
proc contents data=books.ytdsales;
  title "PROC CONTENTS of BOOKS.YTDSALES";
run;


/*******************************************************/
/* End Appendix A                                      */
/*******************************************************/
/*******************************************************/
