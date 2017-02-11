function [smooth_img,x_best,y_best] = main_med_bpso_center(A)


%A = mat2gray(histeq(A));
fstr = @(a) median(a(:));
smooth_img = nlfilter(A,[25 25],fstr);
[height,width] = size(smooth_img);
figure(100);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% BPSO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=10; b=0.1; %a is onvergence and b is convergence rate
% range=[xmin xmax ymin ymax zmin zmax];
range=[0 width 0 height 0 1];

Num_iterations = 5;%<<<<<<<<<<<<<<<<<<<<<<<<<-------------should give intelligence
n = 100; % number of particles
best=zeros(Num_iterations,3);
% ----- Start Particle Swarm Optimization -----------
% generating the initial locations of n particles
xrange=range(2)-range(1);
yrange=range(4)-range(3);
zrange=range(6)-range(5);
xn=(rand(1,n)*xrange+range(1));
yn=(rand(1,n)*yrange+range(3));

% Start iterations
for k=1:Num_iterations,
% Show the contour of the function
  surfc(double(smooth_img)); hold on;
% Find the current best location (xo,yo)
for d = 1:n
    xn = ceil(xn);
    yn = ceil(yn);
zn(d)=smooth_img(yn(d),xn(d));
end
zn_max=max(max(zn));
xo=max(max(xn(zn==zn_max)));
yo=max(max(yn(zn==zn_max)));
zo=max(max(zn(zn==zn_max)));
% Trace the paths of all roaming particles
% Display these roaming particles
plot3(xn,yn,zn,'.',xo,yo,zo,'rp'); axis(range);

% Move all the particles to new locations
nn=size(yn,2);  %a=alpha, b=beta
xn=xn.*(1-b)+xo.*b+a.*(rand(1,nn)-0.5);
yn=yn.*(1-b)+yo.*b+a.*(rand(1,nn)-0.5);
%zn=zn.*(1-b)+zo.*b+a.*(rand(1,nn)-0.5);

%To make sure the particles are within the range
nn=length(yn);
for l=1:nn,
   if xn(l)<=range(1), xn(l)=range(1); end
   if xn(l)>=range(2), xn(l)=range(2); end
   if yn(l)<=range(3), yn(l)=range(3); end
   if yn(l)>=range(4), yn(l)=range(4); end
   %if zn(l)<=range(5), yn(l)=range(5); end
   %if zn(l)>=range(6), yn(l)=range(6); end
end
drawnow;
% Use "hold on" to display paths of particles
hold off;
% History
best(k,1)=xo; best(k,2)=yo; best(k,3)=zo;pause(0.2);
end   %%%%% end of iterations

x_best = best(k,1);
y_best = best(k,2);
z_best = best(k,3);

eye_coordinate =[x_best,y_best];
close all;
