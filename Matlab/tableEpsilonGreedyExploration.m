function a = tableEpsilonGreedyExploration(Q, state, actions, epsilon)

    n_actions = length(actions);
    
    %utforskningsfunksjon med epsilon-grådig
    if(rand() > epsilon)

        a = getBestAction(Q, state, actions);

    else

        a = randi(n_actions);

    end
end