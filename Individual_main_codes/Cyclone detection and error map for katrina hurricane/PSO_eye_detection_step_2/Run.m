% Image Selection
clc;
clear all;
close all;
imSelect = 1;
K = zeros(50, 1, 'uint32');
color_img_pathname = 'C:\Users\Harish\Desktop\Atmospheric research Cyclone Detection (HT)\Cyclone detection and error map on william\output\';
initial_frame_number = 1;
final_frame_number = 50;
for i = initial_frame_number : final_frame_number
    c = imread(strcat(color_img_pathname, num2str(i),'.jpg'));
display(i);
    c=rgb2gray(c);
    [T1, T2, T3, T4, T5] = FiveThresholds(c, imSelect);
    distance=Reconstruction2Thresh(c,T5,T5,i);
end
figure;
plot(K);
%-------------------------------------


