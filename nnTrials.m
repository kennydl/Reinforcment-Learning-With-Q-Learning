function [nn_params, Q, Q_est, tot_reward, i, n_crash, cost, info_s2] = nnTrials(nn_params, input_layer_size, hidden_layer_size,...
                                                                            output_layer_size, alpha, gamma, T, actions, maxsteps,...
                                                                            n_crash, stadium_option, h_car, h_poly, h_circ, radius, wheel_radius, info_s1, h_text)

global mode;
global figure2;

%% ----- Initialization  
cost = 0;
tot_rot = 0;
L = 2*radius;
num_iters = 1;
tot_reward = 0;
nn_params_temp = nn_params;

%% ----- Observe initial sensor values
sensor = checkCrash(h_car, h_poly, h_circ);

%% ----- Trial with max_steps   
for i = 1:maxsteps
    
    % Pause simulation
    if( strcmp(mode,'Pause2') )        
        i = 0;
        tot_reward = 0;
        nn_params = nn_params_temp;
        break; 
    end  
    
    if( strcmp(stadium_option, 'Dynamic') == 1 )
        circularMotion([0,0], h_circ(1:3), pi/200);
        circularMotion([0,0], h_circ(5:end), -pi/200);
    end

    % Feed the sensor values into the Neural Network
    Q = nnFeedForward(nn_params, input_layer_size, hidden_layer_size, ...
                      output_layer_size, sensor);
    
    % Keep sensor values from previous iteration            
    temp_sensor = sensor;              
    
    % Select action with the exploration function
    %a = nnEpsilonGreedyExploration(Q, actions, epsilon);
    a = nnSoftMaxSelection(Q, actions, T);
    
    tot_rot = doActionCircle(a, wheel_radius, L, tot_rot, h_car);   
    [sensor, crash] = checkCrash(h_car, h_poly, h_circ);    
    reward = nnGetReward(a, crash);  
    tot_reward = tot_reward + reward;
    
    % Calculate Q_estimat
    Q_est = computeQEstimate(nn_params, input_layer_size, hidden_layer_size, ...
                                output_layer_size, sensor, reward, gamma);
    
    % Calculate the cost-function and the partial derivatives                        
    [C, grad] = nnBackPropagation(nn_params, input_layer_size, ...
                                        hidden_layer_size, output_layer_size, ...
                                        actions, temp_sensor, a, Q_est);
    
    % Update the weight matrices                                
    nn_params = gradientDescent( nn_params, grad, alpha, num_iters, ...
                                            input_layer_size, hidden_layer_size, ...
                                            output_layer_size);    
    cost = cost + C;
    
    if( crash(2) ), n_crash = n_crash + 1; end
    info_s2 = sprintf('%s%15.3f%17s%16.3f%14s%15.3f', 'Q1:', Q(1), 'Q2:', Q(2), 'Q3:', Q(3));
    info_s2 = sprintf('%s\n%s%9.3f%20s%14d%15s%15.6f', info_s2, 'Q_est:', Q_est, 'Crash:', n_crash, 'cost:', cost/i);
    info_s = sprintf('%s\n%s', info_s1, info_s2);
    set(h_text, 'String', info_s);
    
    if(figure2), drawnow; end      
    if( ~isempty(find(crash,1)) ), break; end 
end

cost = cost/i;

