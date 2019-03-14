** >>>   BE SURE TO ALLOCATE THE LIBREF 'BOOK' TO YOUR DATA SOURCE   <<< **;

** Chapter 8 programs ;

/* Program 8.3  */

* Sort Data by MemberID for BY Group Processing;

proc sort data=book.facilityheader out=facilityheader;              
    by Memberid;
run;

data MemberConditions;
    set facilityheader;
    * BY Group processing;
    by memberid;                                                    
    length Diabetes CHF Depression COPD Asthma $10 Conditions $50;  
    retain Diabetes CHF Depression COPD Asthma;                     
    if first.memberid then do;                                      
      Diabetes="";
      CHF="";
      Depression="";
      COPD="";
      Asthma="";
    end;
    array diag(8) pdx dx_2 dx_3 dx_4 dx_5 dx_6 dx_7 dx_8;           
    do i=1 to 8;
      if diag(i) in: ("250","3572","3620","648","36641") 
        then Diabetes="Diabetes"; 
      if diag(i) in: ("4280") 
        then CHF="CHF";
      if diag(i) in: ("29620","29621","29622","29623","29624",
                      "29625","29630","29631","29632","29633",
                      "29634","29635","2980","3004","3091","311") 
        then Depression="Depression";
      if diag(i) in: ("4912","4932","496","5064") 
        then COPD="COPD";
      if diag(i) in: ("493") 
        then Asthma="Asthma";
    end;
    if last.memberid then do;                                       
      TotConditions = sum((Diabetes   ne ""),(CHF ne ""),
                          (Depression ne ""),(COPD ne ""),
                          (Asthma     ne "")
                         );                                         
      Conditions=catx(", ",Diabetes,CHF,Depression,COPD,Asthma);    
      output;                                                       
    end;
    keep MemberID Sex DOB ToTConditions Conditions Diabetes CHF 
         Depression COPD Asthma;
run;

/* Program 8.4  */

%let Diabetes  = ("250","3572","3620","648","36641");
%let CHF       = ("4280");
%let Depression= ("29620","29621","29622","29623","29624","29625", 
                  "29630","29631","29632","29633","29634","29635",
                  "2980","3004","3091","311");
%let COPD      = ("4912","4932","496","5064");
%let Asthma    = ("493");

data MemberConditions;
    set facilityheader;
    by memberid;
    length Diabetes CHF Depression COPD Asthma $10 Conditions $50;
    retain Diabetes CHF Depression COPD Asthma;
    if first.memberid then do;
      Diabetes="";
      CHF="";
      Depression="";
      COPD="";
      Asthma="";
    end;
    array diag(*) pdx dx_2 dx_3 dx_4 dx_5 dx_6 dx_7 dx_8;
    do i=1 to dim(diag);
      if diag(i) in: &Diabetes   then Diabetes="Diabetes"; 
      if diag(i) in: &CHF        then CHF="CHF";
      if diag(i) in: &Depression then Depression="Depression";
      if diag(i) in: &COPD       then COPD="COPD";
      if diag(i) in: &Asthma     then Asthma="Asthma";
    end;
    if last.memberid then do;                                         
      TotConditions = sum((Diabetes ne ""),(CHF ne ""),
                          (Depression ne ""),(COPD ne ""),
                          (Asthma ne "")
                         );                                  
      Conditions=catx(", ",Diabetes, CHF, Depression, COPD, Asthma);  
      output;                                                         
    end;
    keep MemberID Sex DOB ToTConditions Conditions Diabetes CHF 
         Depression COPD Asthma;
run;

/* Program 8.5  */

option validvarname=any;  /* this necessary option was not mentioned in the book
                             as it is a default for SAS Enterprise Guide where the 
                             ICD9 dataset was created                               */

data DxCntlin(keep=start label fmtname hlo);              
    set BOOK.ICD9(rename=(code=start)) end=last;          
    length fmtname $8;
    label = propcase('Short Nomenclature'n);
    if (   index(start,'.')  = 4                          
        or length(start)     = 3                        
        or substr(start,1,1) = 'E'                      
       )then do;                                          
                fmtname = "$dxN";
                start = compress(start,'.');
                output dxCntlin;
            end;
    if last then do;                                      
                    hlo='O';
                    fmtname = "$dxN";  
                    label='** UNKNOWN DX CODE **'; 
                    output dxCntlin;
                end;
run;

/* Program 8.6  */

proc format library=work cntlin=dxCntlin;              
run;

data test;                                             
    infile cards dsd truncover;
    input ClaimID $ Pdx $ Dx2 $ Dx3 $;
cards;
1,0030,0031,0032
2,0031,0032,
3,0032,,
4,00320,,
5,ZZ222,Z555,
;
run;
data InvalidCodes(keep=ClaimID Error); 
    set test;
    array dx (*) Pdx Dx:;                              
    do i = 1 to dim(dx);  
      if dx(i) = " " then leave;                       
      if put(dx(i),$dxN.) =: "**";                     
      Error = catx(" ","Invalid diagnosis"
                      ,i,"for claim #",ClaimID
                      ,"-- Code is",Dx(i)
                  );                                   
      output;
    end;
run;
