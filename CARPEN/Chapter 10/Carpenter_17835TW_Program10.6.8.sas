* Program 10.6.8.sas
* Using the %HELPCLR and %COLORMAC macros to convert colors;

%helpclr()
%helpclr(all)
%helpclr(rgb)
%colormac()
%put %nrstr(%rgb(100,100,0) = ) %rgb(100,100,0);
%put %nrstr(%RGB2HLS(CXFFFF00) = ) %RGB2HLS(CXFFFF00);
%put %nrstr(%HLS2RGB(H0B480FF) = ) %HLS2RGB(H0B480FF);

