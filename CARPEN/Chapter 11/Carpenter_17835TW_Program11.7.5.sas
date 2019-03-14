* Program 11.7.5.sas
* Building Field Checks;

%macro FldChk;
%local i jj dsncnt fldcnt;
%* Create list of data set names;
proc sql noprint;
   select dsn,keyvar
      into :dsn1-,
           :keys1-
         from macro3.dbdir;
   %let dsncnt=&sqlobs;
   quit;

%* Step through the list of data sets;
%do jj = 1 %to &dsncnt;

   %* Determine field checks for this data set;
   proc sql noprint;
      select dsn,var,chktype,chktext
         into :fdsn1-,
              :fvar1-,
              :ftyp1-,
              :ftxt1-
            from macro3.flddir
               where (upcase(dsn)=upcase("&&dsn&jj"));
      %let fldcnt=&sqlobs;
      quit;

   %if &fldcnt > 0 %then %do;
      * Perform field checks;
      data CheckError_&&dsn&jj(keep= &&keys&jj  _obs_ var 
                                     msg text value chkdate);  
        set macro3.&&dsn&jj;

        * Date these field check problems ;
        * were first detected);
        retain chkdate %sysfunc(today());  
        format chkdate date9.;

        * Specify lengths for the descriptor variables;
        length var $15 value $25 text msg $100;

        * Note the observation number;
        _obs_ = _n_;

        %* Build the Field error checks;
        %do i = 1 %to &fldcnt; 
           %if %upcase(&&ftyp&i) = LIST %then %do; 
              if &&fvar&i not in&&ftxt&i then do;  
                 var = "&&fvar&i";  
                 msg = 'Value is not on list';
                 text = "&&ftxt&i";
                 value = &&fvar&i;
                 output  CheckError_&&dsn&jj;
              end;
           %end;
           %else %if %upcase(&&ftyp&i) = NOTMISS %then %do; 
              if missing(&&fvar&i) then do;  
                 var = "&&fvar&i";  
                 msg = 'Value is missing';
                 text = "&&ftxt&i";
                 value = &&fvar&i;
                 output  CheckError_&&dsn&jj;
              end;
           %end;   
           %else %if %upcase(&&ftyp&i) = FORMAT %then %do; 
              if left(put(&&fvar&i,&&ftxt&i))='.' then do;  
                 var = "&&fvar&i";  
                 msg = 'Formatted Value is missing';
                 text = "&&ftxt&i";
                 value = &&fvar&i;
                 output  CheckError_&&dsn&jj;
              end;
           %end;      
           %else %if %upcase(&&ftyp&i) = EQUALS %then %do; 
              if &&fvar&i ne &&ftxt&i then do;  
                 var = "&&fvar&i";  
                 msg = "&&fvar&i NE &&ftxt&i";
                 text = catt("&&ftxt&i is ",&&ftxt&i);
                 value = &&fvar&i;
                 output  CheckError_&&dsn&jj;
              end;
           %end;  
         %end; %* Complete loop to build field checks; 
      run;
   %end; %* Complete %DO block if fieldcnt>0 for this JJ;
%end; %* complete the JJ across data set loop;
%mend fldchk;
%fldchk
