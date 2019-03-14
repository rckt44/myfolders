The following notes of interest should be considered when using the downloaded data:

The data sets ICD9 and ColDriver have variable names with embedded spaces. This violates SAS naming conventions. 
This is acceptable in SAS Enterprise Guide tasks(where the data sets were created), but not in Base SAS code. 
To work with these variables in Base SAS, two features must be considered:
                    1) set the system option VALIDVARNAME to YES as follows: OPTIONS VALIDVARNAME=YES;
                    2) in Base SAS code use these variable names as name literals: "variable name"n  
                       [e.g., label = propcase("Short Nomenclature"n);]
                     
ERRATA - Chapter 6  

      The Section "Create Outreach Report" (page 70) joins two tables, CurrentMembersKids and ProfessionalVisits.  
      The main idea is to figure out who is only in CurrentMembersKids.  This is why a left join is used.  
      However, the section needs to be changed slightly.  
       
      Under item number (8), remove the filter: BeginDOS=.
       
      Add the filter, BeginDos=., in the FILTER DATA tab of the query.  This creates a WHERE clause rather than
      the JOIN criteria described in item number 8. Please see pages 64 and 65 describing the creation of a basic filter.  
       
      Following is the code that the EG query should produce:
       
      PROC SQL;
          CREATE TABLE WORK.KidsOutreach AS 
          SELECT t1.MemberID, 
                ,t1.DOB
                ,t1.Sex
            FROM WORK.CURRENTMEMBERSKIDS t1
       LEFT JOIN WORK.PROFESSIONALVISITS t2 
              ON (t1.MemberID = t2.MemberID)
           WHERE t2.BeginDOS = .
           ORDER BY t1.DOB;
      QUIT; 
       