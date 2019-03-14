* Program 7.6.1n.sas
* Creating a RGB hex color value;

%macro RGBHex(rr,gg,bb);
%sysfunc(compress(CX
    %sysfunc(putn(%sysfunc(round(&rr)),hex2.))
    %sysfunc(putn(%sysfunc(round(&gg)),hex2.))
    %sysfunc(putn(%sysfunc(round(&bb)),hex2.))))
%mend RGBHex;

%put The 50,150,250 RGB color is %rgbhex(50,150,250);
