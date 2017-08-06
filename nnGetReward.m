function [reward, terminal] = nnGetReward(action, krasj)
    
    % Reward function of the Neural Network

    a = action;
    reward = 0;
    terminal = false;    
    status = ~isempty(find(krasj(2),1));    
    
    r = [0.01, -0.01, -0.01, -0.9];
    
    if( a == 1)
        
        reward = r(1);
    elseif (a == 2)
        
        reward = r(2);        
    elseif ( a == 3 )
        
        reward = r(3);
    end
    
    if(status)
        
        reward = r(4);
        terminal = true;        
    end
    
end