function A=readmat(filenm)
f=fopen(filenm);
text=textscan(f,'%s','delimiter','\n');
fclose(f);
text=text{1};
text=text(3:end);
nm=sscanf(text{1},'%g');
n=nm(1);
m=nm(2);
ifsym=nm(4);
nval=nm(3);
A=zeros(nval,3);
%
for ii=1:nval
  A(ii,:)=sscanf(text{ii+1},'%g');
end
A(:,1)=A(:,1)+1;
A(:,2)=A(:,2)+1;
A=sparse(A(:,1),A(:,2),A(:,3),n,m);
if(ifsym)
 A=A+(triu(A,1))';
end

