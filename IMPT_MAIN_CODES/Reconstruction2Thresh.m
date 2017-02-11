function [c] = Reconstruction2Thresh(c, T1, T2) 

 [M N] = size(c); 
 pp = double(imhist(c));
x0 = T1;
y0 = T2;

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
for i = y0+1:256
    sumT3= sumT3+(i*pp(i));
end

sumTotalT3 = sum(pp(y0+1:256));
ValueTillEnd = round(sumT3/sumTotalT3);


 for i = 1:M
     for j = 1: N
         if c(i,j) < x0
             c(i,j) = ValueTillT1; % assign the value of gray level which occurs maximum number of times in interval 1:x0. Subtract 1 to get actual gray value
         else if  c(i,j) >= x0 && c(i,j) <y0
                 c(i,j) = ValueTillT2;
             else 
                 c(i,j) = ValueTillEnd;
             end
         end
     end
 end
 


                 

