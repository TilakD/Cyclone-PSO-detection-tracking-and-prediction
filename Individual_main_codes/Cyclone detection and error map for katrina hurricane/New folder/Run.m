% Image Selection
clc;
clear all;
close all;
imSelect = 1;
K = zeros(50, 1, 'uint32');
color_img_pathname = 'C:\Users\Tilak\Documents\MATLAB\Cyclone\main_codes\Cyclone detection and error map for katrina hurricane\output\';
initial_frame_number = 9;
final_frame_number = 30;
for i = initial_frame_number : final_frame_number
    c = imread(strcat(color_img_pathname, num2str(i),'.jpg'));
display(i);
    c=rgb2gray(c);
    [T1, T2, T3, T4, T5] = FiveThresholds(c, imSelect);
    Reconstruction2Thresh(c,T5,T5,i);
    pause;
end
figure;
plot(K);

%-------------------------------------


