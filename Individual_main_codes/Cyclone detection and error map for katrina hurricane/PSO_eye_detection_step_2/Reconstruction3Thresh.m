% Lena: 65,94,123,150,186
% Peppers: 43,76,108,141,174
% Baboon: 54,82,111,141,170
% Hunter: 56,87,117,147,182
% Cameraman : 66,95,126,156,203
% Airplane : 56,88,118,150,183
% Map: 57,100,143,164,207
% Living Room : 47,85,127,164,200
% House : 47,72,103,133,169
% Butterfly : 78,97,117,138,163


 
function Reconstruction3Thresh(c, T1, T2, T3)
 figure;
 imshow(c);
 title('Original Image');
  [M N] = size(c);
 pp = double(imhist(c));
x0 = T1;
y0 = T2;
z0 = T3;

sumT1 = 0;
for i = 1:x0
    sumT1 = sumT1+(i*pp(i));
end

sumTotalT1 = sum(pp(1:x0));
ValueTillT1 = round(sumT1/sumTotalT1);

sumT2 = 0;
for i = x0+1:y0
    sumT2 = sumT2+(i*pp(i));
end
sumTotalT2 = sum(pp(x0+1:y0));
ValueTillT2 = round(sumT2/sumTotalT2);


sumT3 = 0;
for i = y0+1:z0
    sumT3= sumT3+(i*pp(i));
end

sumTotalT3 = sum(pp(y0+1:z0));
ValueTillT3 = round(sumT3/sumTotalT3);


sumT4 = 0;
for i = z0+1:256
    sumT4 = sumT4+(i*pp(i));
end
sumTotalT4 = sum(pp(z0+1:256));
ValueTillEnd=round(sumT4/sumTotalT4);



 for i = 1:M
     for j = 1: N
         if c(i,j) < x0
             c(i,j) = ValueTillT1; % assign the value of gray level which occurs maximum number of times in interval 1:x0. Subtract 1 to get actual gray value
         else if  c(i,j) >= x0 && c(i,j) <y0
                 c(i,j) = ValueTillT2;
             else if c(i,j) >= y0 && c(i,j) <z0
                 c(i,j) = ValueTillT3;
                 else
                     c(i,j) = ValueTillEnd;
                 end
             end
         end
     end
 end
 

figure;
imshow(c);
title('Reconstructed Image')
 figure;imhist(c);
 
 %med_bpso_center(c);
