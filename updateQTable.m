function Q = updateQTable(state, a, reward, Q, next_state, alpha, gamma)

	% Update values in the Q-table
  
    Q(state, a) = Q(state,a) + alpha*(reward + gamma* max(Q(next_state,:)) - Q(state,a));
end