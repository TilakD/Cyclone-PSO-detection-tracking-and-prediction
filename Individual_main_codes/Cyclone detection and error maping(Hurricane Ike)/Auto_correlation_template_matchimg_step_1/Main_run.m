clc;
clear all;
close all;
color_img_pathname = 'E:\Image Processing\Cyclone detection\cyclone db\Output_single_fulldisk_BW\';
initial_frame_number = 2;
final_frame_number = 48;
for i = initial_frame_number : final_frame_number
    A = imread(strcat(color_img_pathname, num2str(i),'.jpg'));
display(i);
%A=im2double(imread('15.jpg'));
I=rgb2gray(A);
%I=im2bw(I, 0.5);
   % Template of Eye Lena
    T = imread('template.jpg');
    T=rgb2gray(T);
%T=im2bw(T, 0.5);
   % Calculate SSD and NCC between Template and Image
    [I_SSD,I_NCC]=template_matching(T,I);
   % Find maximum correspondence in I_SDD image
    [x,y]=find(I_NCC==max(I_NCC(:)));
   % Show result
    figure(1), 
     imshow(A); hold on; plot(y,x,'r*'); title('Result');hold off;
   display(x);
    %  display(y);
   %% Crop Image Using Submatrix Operation
                        %select two cursor points
    [m n]= size(I);  
    
   r1 = 50-x; c1 = 50-y;  
   if(r1<0)
       r1=(-1)*r1;
   end
   if(c1<0)
       c1=(-1)*c1;
   end
   
   
 
       %get first cursor point = first corner of the rectangle
   r2 = x+50; c2 = y+50;
   if(r2>m)
       r2=m;
   end
    if(c2>n)
       c2=n;
   end
   %get second cursor point = second corner of the rectangle
   b = A(r1:r2,c1:c2,:);                    %create the sub-matrix
   %b=rgb2gray(b);
   figure(2);
   imshow(b);
  imagename=strcat(int2str(i), '.jpg');
   imwrite(b, strcat('output\',imagename));
   %Run(b);
  
end
   