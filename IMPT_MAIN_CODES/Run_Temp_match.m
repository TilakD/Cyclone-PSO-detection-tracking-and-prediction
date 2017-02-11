function [b] = Run_Temp_match(I,img_number,img_initial_number)

path = 'C:\Users\Tilak\Documents\MATLAB\Cyclone\IMPT_MAIN_CODES\templates\';

if(img_number == img_initial_number);
    T = im2double(rgb2gray(imread('template1.jpg')));
else
     b = imread(strcat(path, num2str(img_number-1),'.jpg'));
     T = b; %generate next tempale
end
    I = im2double((I));
   % Template of Eye Lena
    
   % Calculate SSD and NCC between Template and Image
    [I_SSD,I_NCC]=template_matching(T,I);
   % Find maximum correspondence in I_SDD image
    [x,y]=find(I_NCC==max(I_NCC(:)));
   % Show result
    figure(1), 
    %imshow(I); hold on; plot(y,x,'r*'); title('Result');hold off;
   %display(x);
    %  display(y);
   % Crop Image Using Submatrix Operation
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
   b = I(r1:r2,c1:c2,:);  
  imagename=strcat(int2str(img_number), '.jpg');
  imwrite(b, strcat(path,imagename));
   
   %imshow(b);
