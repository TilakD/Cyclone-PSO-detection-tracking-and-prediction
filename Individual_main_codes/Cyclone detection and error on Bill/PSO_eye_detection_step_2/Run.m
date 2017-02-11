% Image Selection
clc;
clear all;
close all;
imSelect = 1;
M = 4;
K = zeros(36, 1, 'uint32');
color_img_pathname = 'C:\Users\Harish\Desktop\Cyclone detection on Bill\output\';
initial_frame_number = 3;
final_frame_number = 21;
for i = initial_frame_number : final_frame_number
    c = imread(strcat(color_img_pathname, num2str(i),'.jpg'));
display(i);
%c=imread('1 (1).jpg');
%--------------------------------------------

    c=rgb2gray(c);
    if M==2
       [T1, T2] = TwoThresholds(c, imSelect);
       Reconstruction2Thresh(c,T1,T2,i);
    end
    
    if M==3
        [T1, T2, T3] = ThreeThresholds(c,imSelect);
        Reconstruction3Thresh(c, T1, T2, T3,i);
    end
    
    if M==4
        [T1, T2, T3, T4] = FourThresholds(c, imSelect);
        distance=Reconstruction4Thresh(c,T1,T2,T3,T4,i);
    end
    
    if M==5
        [T1, T2, T3, T4, T5] = FiveThresholds(c, imSelect);
        Reconstruction5Thresh(c, T1, T2, T3, T4, T5,i);
    end
    K(i)=distance;
%-------
end
figure;
plot(K);
%-------------------------------------


