%function  Run_MLT(c)
clc;close all;clear all;
c = imread('new_template.jpg');
c = rgb2gray(c);
% Threshold selection
M = 5;
%--------------------------------------------
 
    if M==2
       [T1, T2] = TwoThresholds(c);
       [d] = Reconstruction2Thresh(c,T1,T2);
    end
    
    if M==3
        [T1, T2, T3] = ThreeThresholds(c);
        [d] = Reconstruction3Thresh(c, T1, T2, T3);
    end
    
    if M==4
        [T1, T2, T3, T4] = FourThresholds(c);
        [d] = Reconstruction4Thresh(c,T1,T2,T3,T4);
    end
    
    if M==5
        [T1, T2, T3, T4, T5] = FiveThresholds(c);
        [d] = Reconstruction5Thresh(c,T1,T2,T3,T4,T5);
    end
    
figure(1);imshow(c,[]);title('Original img'); 

figure(2);imhist(c);title('Histogram of original img');
figure(3);surfc(double(c));title('Surface plot of original img');
figure(4);imshow(d,[]);title('Segmented img'); 
figure(5);imhist(d);title('Histogram of segmented img');
figure(6);surfc(double(d));title('Surface plot of segmented img');