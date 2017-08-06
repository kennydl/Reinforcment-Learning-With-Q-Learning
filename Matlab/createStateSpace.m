function state_space = createStateSpace(stadium_option)
	
	%Lage tilstandsrom

    k1 = [0;1;2];
    k2 = [0;1;2];
    k3 = [0;1;2;3];
    k4 = [0;1;2;3];
    k5 = [0;1];
    k6 = [0;1];
    
    if(strcmp(stadium_option, 'Static')), state_space = setprod(k1, k2, k3, k4); 
    
    elseif(strcmp(stadium_option, 'Dynamic')), state_space = setprod(k1, k2, k3, k4, k5, k6);     
    
    end 
    
end