function a = softMaxSelection(Q, state, actions, T)

    n_actions = length(actions);
    P = zeros(1, n_actions);
    
    random = rand();
    
    % Boltzmann distribution
    P = exp(Q(state,:)./T)./sum(exp(Q(state,:)./T));
    
    if( find(isnan(P),1) ~= 0 )
        
       a = getBestAction(Q, state, actions);       
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