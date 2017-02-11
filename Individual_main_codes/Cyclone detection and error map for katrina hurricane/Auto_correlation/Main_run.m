clc;
clear all;
close all;
color_img_pathname = 'C:\Users\Tilak\Documents\MATLAB\Cyclone\main_codes\Cyclone detection and error map for katrina hurricane\Katrina Ordered DB\';
initial_frame_number = 9;
final_frame_number = 45;
T = im2double(imread('template1.jpg'));

  
for i = initial_frame_number : final_frame_number
    A = im2double(imread(strcat(color_img_pathname, num2str(i),'.jpg')));
display(i);
I=A;
   % Template of Eye Lena
    
   % Calculate SSD and NCC between Template and Image
    [I_SSD,I_NCC]=template_matching(T,I);
   % Find maximum correspondence in I_SDD image
    [x,y]=find(I_NCC==max(I_NCC(:)));
   % Show result
    figure(1), 
    imshow(I); hold on; plot(y,x,'r*'); title('Result');hold off;
   %display(x);
    %  display(y);
   %% Crop Image Using Submatrix Operation
                        %select two cursor points
    [m n]= size(I);  
    
   r1 = 70-x; c1 = 70-y;  
   if(r1<0)
       r1=(-1)*r1;
   end
   if(c1<0)
       c1=(-1)*c1;
   end
   
  %get first cursor point = first corner of the rectangle
   r2 = x+70; c2 = y+70;
   if(r2>m)
       r2=m;
   end
    if(c2>n)
       c2=n;
   end
   %get second cursor point = second corner of the rectangle
   b = A(r1:r2,c1:c2,:);  
   T=b;%generate next tempale
   imshow(b);
   %pause;
   imagename=strcat(int2str(i), '.jpg');
   imwrite(b, strcat('output\',imagename));
   
end
   