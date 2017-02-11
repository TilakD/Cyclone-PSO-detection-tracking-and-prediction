function [x0,y0] = TwoThresholds(c, imSelect, thresholdLevel)

 [M N] = size(c);

 
 c2 =double((1+sqrt(5))/2);   %acceleration constant
 c1 = double(c2 - 1);  %acceleration constant
 r1 = rand(1);
 r2 = rand(1);
 inertia = 1; % inertial weight
 Swarmsize = 20;  % swarm size
 index = 1; 
 iterations = 0;
  funcVal=0;
 k = 2; %index for gBestDifference array
 
 for i = 1:5
     for j= 5:8
         X(index,1) = round(255*rand(1));  %initialize x positions(here, coordinates) with random values
         X(index,2) =round( 255*rand(1));  %initialize y positions(here, coordinates) with random values
         index = index+1; 
     end
 end
 

 pBest(Swarmsize,2) = 0;
 pBest(:,1)=0;% initializations
 pBest(:,2) = 0;
 
 vel(Swarmsize,2) = 0;
 vel(:,1) = 0;
 vel(:,2) = 0;
 
 BestFuncVal(Swarmsize,1) = 0;
 BestFuncVal(:,1) =0;
 
 pp = double(imhist(c)); % used later for finding index of max pp
 p =double( imhist(c)./(M*N));
 p = p';
 maxIterations = 100;
 while iterations<maxIterations
     
     for i=1:Swarmsize
             %------------------------------------
             if vel(i,1) < -15
                 vel(i,1) = -15;
             end
              if vel(i,1)> 15
                 vel(i,1) = 15;
              end
             %------------------------------------
             if vel(i,2) < -15
                 vel(i,2) = -15;
             end
             if vel(i,2)> 15
                 vel(i,2) = 15;
             end 
             %-----------------------------------
            
         X(i,1) = X(i,1)+vel(i,1);
         if X(i,1) < min(min(c));
             X(i,1) = min(min(c));
         end
          if  X(i,1) > max(max(c));
              X(i,1) = max(max(c));   
          end                                            %update x in accordance with formula X(t+1) = X(t) + V(t+1). Here V(t+1) is initialized vel vector in the 1st iter
         %--------------------------------------- 

         X(i,2) = X(i,2)+vel(i,2); %update y in accordance with formula X(t+1) = X(t) + V(t+1). Here V(t+1) is initialized vel vector in the 1st iter
         if X(i,2) < min(min(c));
             X(i,2) = min(min(c));
         end
          if  X(i,2) > max(max(c));
              X(i,2) = max(max(c));   
          end 
          %--------------------------------------
        
          %----------------------------
          % for Lena use the condition x0 == 25 y0 ==25 etc in line 138
        % for Hunter, Baboon,cameraman,LivingRoom,House,peppers,Map use the condition x0 ==0 y0 ==0 etc
        % for aiplane use the condition x0 ==16 y0 ==16 etc
        % for Butterfly use x0 ==27, y0 == 27 etc.
                
                 x0=round(X(i,1));
                 y0=round(X(i,2)); 
               
               if isnan(funcVal) || x0 ==0 || y0==0
                     x0 = round(255*rand(1));
                     y0 = round(255*rand(1));
                     Values =[x0 y0];
                     sortValues = sort(Values);
                    x0 = sortValues(1);
                    y0 = sortValues(2);
                   
              end  
                
         %------------------------------------
%           disp(x0)
%           disp(y0)
                  pA = sum(p(1:x0));
                  pAsum = (p(1:x0)./pA).^4;
                  pA1 = sum(pAsum);
                 SA = (1- pA1) / 3;
      %-------------------------------------------------------------------------
       %-----------------------------------------------------------------------
                 pB = sum(p((x0+1):y0));
                 pBsum = (p((x0+1):y0)./pB).^4;
                 pB1 = sum(pBsum);
                 SB = (1- pB1) / 3;
     %------------------------------------------------------------- 
                  pC= sum(p((y0+1):256));
 
                pCsum = (p((y0+1):256)./pC).^4;
               pC1 = sum(pCsum);
         
              SC= (1- pC1) / 3;        
         %---------------------------------------------------
                
              
         
      funcVal = double((SA+SB+SC)+(-3*SA*SB*SC));%determine function value at x=x0, y = y0; ie fitness function of the current particle
         if (funcVal>BestFuncVal(i,1) && (x0<y0))       %if function value is less than the current best of (x,y) update pbestx, pbesty
             pBest(i,1) = x0;             % here it remembers its personal best encountered so far i.e memory is in pBest
             pBest(i,2) = y0;
             
             BestFuncVal(i,1) = funcVal;  % also update the best value(global best)encountered so far
         end
     end % when for i = 1:size ends here all particles would have their pBests stored in pBest array 
     
     [temp,gbest] = max(BestFuncVal(:,1)); % obtain the best of all the pBests since you are minimizing here you say min(BestFuncVal) and note that the BestFuncVal 
                                           % obtained by substituting pBest
    %so min(BestFuncVal) = min(function values obtained by subs pBests)
                           
%    gBestDifference(k) = x0;  
   Wmax = 0.4;
   Wmin = 0.1;
   
   inertia = Wmax - ((Wmax-Wmin)*iterations/maxIterations);
     
     for i = 1:Swarmsize    % use formulae defined in PSO algorithm to update x and y velocity components.
        vel(i,1) = inertia*vel(i,1) + c1*rand*(pBest(i,1)-X(i,1))+c2*rand*(pBest(gbest,1)-X(i,1)); % update x velocity component.
        vel(i,2) = inertia*vel(i,2) + c1*rand*(pBest(i,2)-X(i,2))+c2*rand*(pBest(gbest,2)-X(i,2)); % update y velocity component.
        
     end
     

%      k=k+1; 
     iterations = iterations+1; % increment iterations
     

 end
 
 