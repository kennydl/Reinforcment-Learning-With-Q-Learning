function [reward, terminal] = getReward(action, prev_action, sensor1, sensor2, krasj)

    % Reward function for Q-learning with table

    r1 = 0;
    r2 = 0;
    r3 = 0;
    reward = 0;
    
    status_krasj = ~isempty(find(krasj(2),1));
    terminal = false;
    a = action;
        
    switch(a)
       
        case 1, r1 = 0.2;
        case 2, r1 = -0.1;
        case 3, r1 = -0.1;
            
    end
    
    if (sum(sensor2 - sensor1) >= 0)
        
        r2 = 0.2;        
    else
        
        r2 = -0.2;
    end    
    
   if(prev_action == 2 && a == 3)
      
       r3 =  -0.8;      
   elseif(prev_action == 3 && a == 2)
        
       r3 = -0.8;
   end
     
   reward = r1 + r2 + r3;
   
   if(status_krasj)
       
       terminal = true;
       reward = -100;
   end

end