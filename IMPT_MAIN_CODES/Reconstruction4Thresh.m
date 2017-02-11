function [c] = Reconstruction4Thresh(c, T1, T2, T3, T4, T5)

  [M N] = size(c);
  pp = double(imhist(c));
x0 = T1;
y0 = T2;
z0 = T3;
a0 = T4;
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
for i = z0+1:a0
    sumT4 = sumT4+(i*pp(i));
end
sumTotalT4 = sum(pp(z0+1:a0));
ValueTillT4=round(sumT4/sumTotalT4);

sumT5 = 0;
for i = a0+1:256
    sumT5= sumT5+(i*pp(i));
end
sumTotalT5 = sum(pp(a0+1:256));
ValueTillEnd=round(sumT5/sumTotalT5);




 for i = 1:M
     for j = 1: N
         if c(i,j) < x0
             c(i,j) = ValueTillT1; % assign the value of gray level which occurs maximum number of times in interval 1:x0. Subtract 1 to get actual gray value
         else if  c(i,j) >= x0 && c(i,j) <y0
                 c(i,j) = ValueTillT2;
             else if c(i,j) >= y0 && c(i,j) <z0
                 c(i,j) = ValueTillT3;
                 else if c(i,j) >=z0 && c(i,j) <a0
                     c(i,j) = ValueTillT4;
                     else 
                             c(i,j) = ValueTillEnd;
                     end
                 end
             end
         end
     end
 end

                 
 