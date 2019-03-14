* Program 13.2.3.sas
* Build a series of linked reports;

%macro clinrpt(loc=,dir=);
   ods escapechar='~';
   proc sort data=macro3.clinics
             out=clinics 
             nodupkey;
      by region clinname;
      run;

   data _null_;
      set clinics end=eof;
      by region;
      if first.region then do;
         rcnt+1;
         call symputx(catt('reg',region),region,'l');
      end;
      ccnt+1;
      call symputx(catt('creg',ccnt),region,'l');
      call symputx(catt('cnum',ccnt),clinnum,'l');
      call symputx(catt('cnam',ccnt),clinname,'l');
      if eof then do;
         call symputx('regcnt',rcnt,'l');
         call symputx('clncnt',ccnt,'l');
      end;
      run;
   proc format;
      value $regname
         '1' = 'North East'
         '2' = 'New York'
         '3' = 'Central East'
         '4' = 'South East'
         '5' = 'Mid West'
         '6' = 'Texas'
         '7' = 'Central Plains'
         '8' = 'Rocky Mtn.'
         '9' = 'South Western'
         '10'= 'Pacific Northwest';
      run;

   %regindex
   %regrpt
   %clinicrpt
%mend clinrpt;

%macro regindex; 
   %local i;
   * Create the Region Index;
   data masterlist;
      length region $2 RegName $100;
      %do i = 1 %to &regcnt;
         region="&&reg&i"; 
         RegName=catt("~{style [url='",
                      "&loc\&dir\RegRpt_&&reg&i...pdf']}",
                      put("&&reg&i",$regname.));
         output masterlist;
      %end;
      *put regname=;
      run;
      
   ods pdf file=%tslit(%chkdir2(dirloc=&loc,dirname=&dir)\Master.pdf);
   title1 'Master Index to the Regional Reports';
   proc print data=masterlist noobs;
      var region regname;
      run;
   ods pdf close;
%mend regindex;

%macro regrpt; 
%local i;
* Create a preport for each Region;
%do i = 1 %to &regcnt;
   * Step through the individual regions;
   ods pdf file="&loc\&dir\RegRpt_&&reg&i...pdf";
   title1 "Visit Counts for the "
          "%qtrim(%qsysfunc(putc(&&reg&i, $regname.))) Region";
   title2 link="&loc\&dir\Master.pdf" 
          "Return to the Master Index";

   proc report data=macro3.clinics(where=(region="&&reg&i"));
      column clinnum clinname n;
      define clinnum / group 'Clinic Number';
      define clinname/ group 'Clinic Name';
      define n / 'Visit Count';
      compute clinname;
         link = catt("&loc\&dir\ClinicRpt_",
                     clinnum,
                     '.pdf');
         call define(_col_, 'url', link);
      endcomp;
      run;
   ods pdf close;
%end;
%mend regrpt;


%macro clinicrpt; 
%local i;
* Create a preport for each clinic;
%do i = 1 %to &clncnt;
   * Step through the individual regions;
   ods pdf file="&loc\&dir\ClinicRpt_&&cnum&i...pdf";
   title1 "Clinic Visit Details for the &&cnam&i Clinic";
   title2 link="&loc\&dir\RegRpt_&&creg&i...pdf" 
          "Return to the Region Report for this Clinic";

   proc report data=macro3.clinics(where=(clinnum="&&cnum&i"));
      column lname fname dob exam symp;
      define lname / display 'Last Name';
      define fname / display 'First Name';
      define dob   / display 'Date of Birth' f=date9.;
      define exam  / display 'Exam Date' f=date9.;
      define symp  / display 'Symptom Code';
      run;
   ods pdf close;
%end;
%mend clinicrpt;


%clinrpt(loc=c:\temp, dir=RegionReports)




