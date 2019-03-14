DATA _NULL_;
date = 19855;
datetime = 1705587720;
PUT "MMDDYY10. representation of date=" date mmddyy10.; ?
PUT "MONYY7. representation of date=" date monyy7.; ?
PUT "DTMONYY7. representation of date=" date dtmonyy.; ?
PUT "When value of date is used as a SAS *datetime* value, the date represented is:" date datetime20.;?

PUT "DATETIME20. representation of datetime=" datetime datetime20.; ?
PUT "DTMONYY7. representation of datetime=" datetime dtmonyy7.; ?
PUT "MONYY7. representation of datetime=" datetime monyy7.; ?
PUT "When value of datetime is used as a SAS *date* value, the date represented is:" datetime mmddyy10.; ?
RUN;
