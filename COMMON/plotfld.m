function []=plotfld(x,y,u,m,n,tit)
xmin=min(x);
xmax=max(x);
dx=(xmax-xmin)/(n-1);
X=[xmin:dx:xmax];
ymin=min(y);
ymax=max(y);
dy=(ymax-ymin)/(m-1);
Y=[ymin:dy:ymax];
[X,Y]=meshgrid(X,Y);
%U=interpscatdata(x,y,u,X,Y);
U=griddata(x,y,u,X,Y);
umax=max(u);
umin=min(u);
nl=20;
du=(umax-umin)/(nl-1);
vv=[umin:du:umax];
%[cs,h]=contour(X,Y,U,vv);
pcolor(X,Y,U); shading interp;
axis('equal'); axis tight;
colorbar
%clabel(cs,vv);
xlabel x
ylabel y;
title(tit);

