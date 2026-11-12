clear all; close all;
global DDx DDy AA Ad;
addpath ../COMMON;

% ************************************************************************* %
% GET SETTINGS + READ MATRICES AND BOUNDARY INFO
% ------------------------------------------------------------------------- %
% Physical and numerical settings
Re=100;
dt=0.01; Nstep=400;
%dt=0.001; Nstep=500000;
Niter=2;
% ------------------------------------------------------------------------- %
% Read mesh info
x=readarray('x.dat');
y=readarray('y.dat');
Mp=readmat('Mp.dat'); % This quantity is necessary to re-scale the pressure
% ------------------------------------------------------------------------- %
% Read Finite-Element matrices
K=readmat('K.dat');
M=readmat('M.dat');
Dx=readmat('divx.dat');
Dy=readmat('divy.dat');
Dx_vel=readmat('gradx.dat');
Dy_vel=readmat('grady.dat');
[n,m]=size(K)
[np,nv]=size(Dx)
A=1/dt*M+1/Re*K;
% ------------------------------------------------------------------------- %
% Get indices for the boundary conditions
bc=readarray('bc.dat');
bcnz=readarray('bcnz.dat');
ii=find(bc==0);
ibcnz=find(abs(bcnz)>0);
nvv=length(ii);
AA=A(ii,ii);
DDx=Dx(:,ii);
DDy=Dy(:,ii);
KK=K(ii,ii);
%
% Transpose matrices to be consistent with formulation
DDx=DDx'; Dx=Dx';
DDy=DDy'; Dy=Dy';
AAinv=inv(AA);
%
Q=DDx'*AAinv*DDx+DDy'*AAinv*DDy;


% ************************************************************************* %
% COMPUTATION
% ------------------------------------------------------------------------- %
% Initialization
u0=zeros(nv,1);
u0(ii)=0;
u0(ibcnz)=1;
v0=zeros(nv,1);
p0=zeros(np,1);
nnv=length(ii);
for nt=1:Nstep
   if (mod(nt,10)==0) 
      disp(sprintf('iteration %d',nt));
   end
   %residuals
   Rx=-(1/Re*K*u0-Dx*p0);
   Ry=-(1/Re*K*v0-Dy*p0);
   S=-(Dx'*u0+Dy'*v0);
   %
   dp0=p0;
   du=zeros(nnv,1);
   dv=zeros(nnv,1);
   %
   % Step1
   ustar=AAinv*Rx(ii);
   vstar=AAinv*Ry(ii);
   Resp=S - DDx'*ustar - DDy'*vstar;
   %
   dp=Q\Resp;
   %
   % Step3
   du=ustar+AAinv*DDx*dp;
   dv=vstar+AAinv*DDy*dp;
   %
   % Step 4
   p=p0+dp;
   u=u0;
   u(ii)=u(ii)+du;
   v=v0;
   v(ii)=v(ii)+dv;
   u0=u;
   v0=v;
   %
   % Rescale pressure
   Area=ones(1,np)*Mp*ones(np,1);
   pmean=ones(1,np)*Mp*p/Area;
   p0=p-pmean;% subtract mean value
   % % Visualize
   % if (mod(nt,100000)==0) 
   %    FIG=figure('color','w','Visible','off');
   %    plotfld(x,y,u,64,64,'u');
   %    caxis([-0.3 1]);
   %    savename=['PIC/PIC_' sprintf('%06d',nt)];
   %    exportgraphics(FIG,[savename '.png']);
   %    close all;
   % end
end

% Visualize solution
FIG=figure('color','w','Visible','on');
   plotfld(x,y,u,64,64,'u');
   caxis([-0.3 1]);
   savename=['Velocity_u_Final'];
   exportgraphics(FIG,[savename '.png']);


save('solution_NS.mat','x','y','u','v','dt','Nstep','Re');
