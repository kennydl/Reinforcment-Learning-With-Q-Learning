function W = randInitializeWeights(L_in, L_out)
	
	% Initialize the weight matrices with random values between [0, 0.1] 

	W = 0.1.*rand(L_out, 1 + L_in);
               
end
