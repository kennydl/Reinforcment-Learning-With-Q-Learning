function [state_index, k1, k2, k3, k4] = discretization(state_space, sensor, dyn_obj, stadium_option)
    
    k1 = 2;         %Left zone
    k2 = 2;         %Right sone
    k3 = 3;         %Left sector    
    k4 = 3;         %Right sector
    k5 = 0;         %Left static/dynamic
    k6 = 0;         %Right static/dynamic
    
    % Find the left side sensor values of the vehicle 
    x = min(sensor(1:3));          
    if( x > 40 && x < 70)

        k1 = 1;         %zone 1
        
    elseif( x < 40)
        
        k1 = 0;         %zone 0
        
    end

    % find the right sensor values of the vehicle
    x = min(sensor(3:end));        
    if( x > 40 && x < 70)
        
        k2 = 1;         %zone 1
    
    elseif(  x < 40)
        
        k2 = 0;         %zone 0
        
    end       
    
    i = sensor < 100;
    
    % The left sector of the vehicle
    if( ((i(2) == 1 || i(3) == 1) && i(1) == 0))
        
        k3 = 0;         %sector 0
    
    elseif( (sum(i(1:2)) == 2 || i(1) == 1) && i(3) == 0 )
        
        k3 = 1;         %sector 1
        
    elseif( sum(i(1:3)) == 3 )    
        
        k3 = 2;         %sector 2     
    end        

    % The right sector of the vehicle
    if( ((i(3) == 1 || i(4) == 1) && i(end) == 0) )
        
        k4 = 0;         %sector 0
    
    elseif( (sum(i(4:end)) == 2 || i(end) == 1) && i(3) == 0 )
        
        k4 = 1;         %sector 1
        
    elseif( sum(i(3:end)) == 3)
        
        k4 = 2;         %sector 2
    end          
    
    x1 = max(dyn_obj(1:3));
    x2 = max(dyn_obj(3:end));

    if( x1 > 0)
        
        k5 = 1;         %dynamic obstacles
    end    
    
    if( x2 > 0 )
        
        k6 = 1;         %dynamic obstacles
    end
    
    % Find the state index in the Q-table
    if(strcmp(stadium_option,'Static')), [d, index] = min(dist(state_space, [k1, k2, k3, k4]'));
        
    elseif(strcmp(stadium_option,'Dynamic')), [d, index] = min(dist(state_space, [k1, k2, k3, k4, k5, k6]'));
        
    end
    
    state_index = index;
end