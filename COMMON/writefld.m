function []=writefld(u,filnm)
n=length(u);
fid=fopen(filnm,'w');
fprintf(fid,'%i\n',n);
fprintf(fid,'%16.8g %16.8g %16.8g %16.8g %16.8g\n',u);
fclose(fid);
