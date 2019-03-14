PROC FORMAT;
PICTURE rptdate (DEFAULT=43)
. - .Z = 'Missing'
LOW-HIGH = 'Generated on %B %d, %Y at %I:%0M %p' (DATATYPE=DATETIME);
RUN;

DATA _NULL_;
rpt_date = "15dec2012:22:25:00"dt;
PUT 'SAS datetime value = ' rpt_date;
PUT 'Formatted with DATETIME. = ' rpt_date datetime.;
PUT 'Using custom format at width of 35 =' rpt_date rptdate35.;
PUT 'Using custom format at default width of 43 = ' rpt_date rptdate.;
RUN;
