function g = tanhActivation(z)
    
    % Activation function with hyperbolic tangent

    g = (exp(2.*z)-1) ./ (exp(2.*z) + 1); 
end
