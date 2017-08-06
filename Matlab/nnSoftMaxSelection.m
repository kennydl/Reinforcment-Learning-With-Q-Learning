function a = nnSoftMaxSelection(Q, actions, T)
    
    % Exploration function of the Q-learning with Neural Network 

    random = rand();
    n_actions = length(actions);
    P = zeros(1, n_actions);
    
    % Boltzmann distribution
    P = exp(Q(:)./T)./sum(exp(Q(:)./T));
    
    if( find(isnan(P),1) ~= 0 )
        
       [Q_value, a] =  max(Q);  
       
    else
        
        if(random < P(1))

            a = 1;

        elseif(random >= P(1) && random < sum(P(1:2)) )

            a = 2;
        elseif(random >= sum(P(1:2)))

            a = 3;
        end
    end
    
end