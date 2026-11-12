function x=readarray(filenm)
f=fopen(filenm);
x=fscanf(f,'%g');
fclose(f);
n=x(1);
x=x(2:end);

