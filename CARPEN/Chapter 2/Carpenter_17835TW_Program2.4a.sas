* Program 2.4a  Comparing PUT and %PUT;

data _null_;
  do j = 1 to 5;
     put j ' Placed by PUT';
     %put j ' Placed by macro PUT';
  end;
  run;
