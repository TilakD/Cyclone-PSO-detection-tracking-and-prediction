
function[distance]=med_bpso_center(A,i)
display('entered the BPSO');
fstr = @(a) mean(a(:));
smooth_img = nlfilter(A,[50 50],fstr);
a=0.2; b=0.5; 
[m,n]=size(A);
% range=[xmin xmax ymin ymax];
range=[0 n 0 m];

Num_iterations = 10;%<<<<<<<<<<<<<<<<<<<<<<<<<----------------------------should give intelligence
n = 40; % number of particles
best=zeros(Num_iterations,3);
% ----- Start Particle Swarm Optimization -----------
% generating the initial locations of n particles
xrange=range(2)-range(1);
yrange=range(4)-range(3);
xn=(rand(1,n)*xrange+range(1));
yn=(rand(1,n)*yrange+range(3));

% Start iterations
for k=1:Num_iterations,
% Show the contour of the function
  imshow(A); hold on;
% Find the current best location (xo,yo)
for d = 1:20
    xn = ceil(xn);
    yn = ceil(yn);
zn(d)=smooth_img(yn(d),xn(d));
end
zn_min=max(zn);
xo=max(xn(zn==zn_min));
yo=max(yn(zn==zn_min));
zo=max(zn(zn==zn_min));
% Trace the paths of all roaming particles
% Display these roaming particles
plot(xn,yn,'.',xo,yo,'rp'); axis(range);

% Move all the particles to new locations
nn=size(yn,2);  %a=alpha, b=beta
xn=xn.*(1-b)+xo.*b+a.*(rand(1,nn)-0.5);
yn=yn.*(1-b)+yo.*b+a.*(rand(1,nn)-0.5);

% Make sure the particles are within the range
nn=length(yn);
for l=1:nn,
   if xn(l)<=range(1), xn(l)=range(1); end
   if xn(l)>=range(2), xn(l)=range(2); end
   if yn(l)<=range(3), yn(l)=range(3); end
   if yn(l)>=range(4), yn(l)=range(4); end
end
drawnow;
% Use "hold on" to display paths of particles
hold off;
% History
best(k,1)=xo; best(k,2)=yo; best(k,3)=zo;
end   %%%%% end of iterations

x_best = best(k,1);
y_best = best(k,2);
z_best = best(k,3);

eye_coordinate =[x_best,y_best]

figure(3);
imshow(A,[]);
hold on
plot(x_best, y_best, 'bx') %center or eye
% Draw circle of required radius arround it if eye is detected.
theta = 0:pi/50:2*pi;
radius_1 = 15;
xunit_circle_1 = radius_1 * cos(theta) + x_best;
yunit_circle_1 = radius_1 * sin(theta) + y_best;
h_1 = plot(xunit_circle_1, yunit_circle_1,'r');
hold off
title('approximate center with error');
%info = geotiffinfo(A);

%[x,y] = pix2map(info.RefMatrix, x_best, y_best);
%[lat,lon] = projinv(info, x,y);
%display(lat);
%display(lon);

[x_ori,y_ori] = ginput(1);
distance = sqrt((x_best-x_ori)^2+(y_best-y_ori)^2);
display(distance);
%degrees = km2deg(distance);
%display(degrees);


end






