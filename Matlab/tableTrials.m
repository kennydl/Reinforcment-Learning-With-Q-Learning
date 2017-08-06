function [Q, tot_reward, i, n_crash, info_s2] = tableTrials(Q, alpha, gamma, T, ...
                                                            stadium_option, h_car, h_circ, h_poly, state_space, action_list, ...
                                                            max_steps, n_crash, radius, wheel_radius, info_s1, h_text)
                                                     
    global mode;
    global figure1;
    
    %% ----- Initialize parameters 
         
    prev_a = 0;                                    
    tot_reward = 0;
    tot_rot = 0;
    B = 2*radius;
    dyn_obj = [0, 0, 0, 0, 0];
    Q_temp = Q;
    
    
    %% ----- Observe initial state
    
    % Get sensor values
    sensor = checkCrash(h_car, h_poly, h_circ);
    
    % Discretization of the sensor values 
    state = discretization(state_space, sensor, dyn_obj, stadium_option);
    
    %% ----- Trial with max_steps      
    for i = 1:max_steps
        
        % Pause simulation
        if( strcmp(mode,'Pause1') )                       
            i = 0;
            tot_reward = 0;
            Q = Q_temp;    
            break; 
        end
        
        % Keep sensor values from previous iteration
        prev_sensor = sensor;
        
        if( strcmp(stadium_option, 'Dynamic') == 1 )
            temp_sensor1 = checkCrash(h_car, h_poly, h_circ);
            circularMotion([0,0], h_circ(1:3), pi/200);
            circularMotion([0,0], h_circ(5:end), -pi/200);
            temp_sensor2 = checkCrash(h_car, h_poly, h_circ);
            dyn_obj = temp_sensor1 - temp_sensor2;         
        end
        
        % Select action with the exploration function
        %a = tableEpsilonGreedyExploration(Q, state, action_list, epsilon);
        a = softMaxSelection(Q, state, action_list, T);
        
        switch(a)       
            case 1, action = 'forward'; 
            case 2, action = 'right';          
            case 3, action = 'left';     
        end
                             
        tot_rot = doActionCircle(a, wheel_radius, B, tot_rot, h_car);
        [sensor, crash] = checkCrash(h_car, h_poly, h_circ);
        [next_state, k1, k2, k3, k4] = discretization(state_space, sensor, dyn_obj, stadium_option);        
        reward = getReward(a, prev_a, prev_sensor, sensor, crash);
        tot_reward = tot_reward + reward;
        
        % Update Q-table
        Q = updateQTable(state, a, reward, Q, next_state, alpha, gamma);
              
        % Keep the last action change state to next_state
        prev_a = a;
        state = next_state;
        
        if( crash(2) ), n_crash = n_crash + 1; end      
        info_s2 = sprintf('%s%10d%24s%8d%18s%17s', 'l_zone:', k1, 'r_zone:', k3, 'Action:', action);        
        info_s2 = sprintf('%s\n%s%10d%24s%8d%14s%10d', info_s2, 'l_sector:', k2, 'r_sector:', k4, 'Crash:', n_crash);       
        info_s = sprintf('%s\n%s', info_s1, info_s2);
        set(h_text, 'String', info_s);
        
        if(figure1), drawnow; end               
        if( ~isempty(find(crash,1)) ), break; end
    end    
end