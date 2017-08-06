function g = tanhDerivative(z)

    % The derivative of the hyperbolic tangent
    
    g = ((4.*(cosh(z)).^2)./((cosh(2*z)+1).^2));
end