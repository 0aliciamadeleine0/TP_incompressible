% *************************************************************************** %
% This script compares simulated data at Re=100 with the reference data from 
% the publication "High-Re Solutions for Incompressible Flow Using the 
% Navier-Stokes Equations and a Multigrid Method" from Ghia, Ghia and Shin 
% (JCP 1982).
% It plots the evolution of the velocity along vertical and horizontal lines
% *************************************************************************** %
clear all; close all;

set(0,'defaultAxesFontSize',20);
set(0,'defaultAxesLineWidth',2);
set(0,'defaultLineLineWidth',2);

% Load reference data
buff=load('Re100_Ux.dat');
yplot_ref=buff(:,1)-0.5; % Center y axis as in our case
Uref_Re100=buff(:,2);
buff=load('Re100_Uy.dat');
xplot_ref=(buff(:,1)-0.5); % Center x axis as in out case
Vref_Re100=buff(:,2);



% Visualize u along vertical line through geometric center
FIG1=figure('color','w');
plot(Uref_Re100,yplot_ref,'xr','MarkerSize',10,...
    'DisplayName','Ghia et al. (1982) - Re=100');
hold on

% Visualize v along horizontal line through geometric center
FIG2=figure('color','w');
plot(xplot_ref,Vref_Re100,'xr','MarkerSize',10,...
    'DisplayName','Ghia et al. (1982) - Re=100');
hold on

% Add simulated data
load('solution_NS.mat'); % Simulated data
xmin=min(x); xmax=max(x);
ymin=min(y); ymax=max(y);

% Visualize u along vertical line through geometric center
yplot=linspace(ymin,ymax,100);
xplot=0.0*ones(size(yplot));
Uplot=griddata(x,y,u,xplot,yplot);
Uplot=Uplot';
figure(FIG1)
legend_name=sprintf('Simulation, Re=%g', Re);
plot(Uplot(:,1),yplot,'DisplayName',legend_name)

% Visualize v along horizontal line through geometric center
xplot=linspace(xmin,xmax,100);
yplot=0.0*ones(size(xplot));
Vplot=griddata(x,y,v,xplot,yplot);
Vplot=Vplot';
figure(FIG2)
legend_name=sprintf('Simulation, Re=%g', Re);
plot(xplot,Vplot(:,1),'DisplayName',legend_name)


% Add legends
figure(FIG1)
mylegend=legend('show');
set(mylegend,'Location','East');
ylabel('y/l'); xlabel('u/U_{ref}');
axis([-0.5 1.0 ymin ymax]);

figure(FIG2)
mylegend=legend('show');
xlabel('x/l'); ylabel('v/U_{ref}')
axis([xmin xmax -0.-0.5 0.5]);
