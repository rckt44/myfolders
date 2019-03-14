* Program 6.2.3e
* Creating coordinated numbered lists;
proc sql noprint;
select distinct clinname, count(*)
    into :name1-, 
         :cnt1-
        from macro3.clinics 
            group by clinname; 
quit;
%put _user_;
