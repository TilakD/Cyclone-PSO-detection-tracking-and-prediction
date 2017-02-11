clc;close all; clear all;
pathname = 'C:\Users\Tilak\Desktop\Paper Work\GOES-12\GOES-12 Ordered\Katrina_FD\';%<<<<histeq database
initial_frame_number = 21;
final_frame_number = 48;



for i = initial_frame_number : final_frame_number
A = rgb2gray(imread(strcat(pathname, num2str(i),'.jpg'))); 
mask = im2bw(rgb2gray(imread('mask.jpg')));

new_segmented_center_part = immultiply(A,mask);
 
 [segmented_img] = Run_MLT(new_segmented_center_part);

%segmented_img = mat2gray(histeq(segmented_img));
[Template] = Run_Temp_match(segmented_img,i,initial_frame_number);

% Eye and Spiral
[smooth_img,x_best,y_best] =  main_med_bpso_center(Template);

%%
figure(1);
subplot(2,2,1);
 imshow(new_segmented_center_part,[]);
 title('Original Image');
 
subplot(2,2,2);
imshow(segmented_img);
title('Reconstructed Image');

subplot(2,2,3);
imshow(Template);
title('Template Image');

subplot(2,2,4);
imshow(smooth_img);
title('median filtered Image');

t = -30:0.1*pi:20;
xc = x_best;
yc = y_best;
crvx = xc + ((exp(0.2*t)).*(cos(t)));
crvy = yc + ((exp(0.2*t)).*(sin(t)));
dvx = -diff([0 crvx]); %rempve 1 to get arrows on the line
dvy = -diff([0 crvy]);

imshow(Template);
hold on
plot(crvx, crvy, '-b')
quiver(crvx,crvy, dvx,dvy, 'r')
%plot(dvx, dvy, '-r')
hold off
grid
pause;close all;

end