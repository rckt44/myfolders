* Program 7.4.1b.sas
* Using %SYSCALL to generate random numbers;

%let seed=0;
%let rand=0;
%put seed is &seed pseudo random number is &rand;
%syscall ranuni(seed,rand);
%put seed is &seed pseudo random number is &rand;
