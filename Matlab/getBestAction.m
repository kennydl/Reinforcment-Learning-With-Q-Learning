function a = getBestAction(Q, state, actions)
    
    % Select the best action a in state s

    n_actions = length(actions);
    status = find(Q(state,:), 1);
      
    if isempty(status)
        
        a = randi(n_actions);        
    else
        
        [Q_value, a] = max(Q(state,:));       
    end
    
end