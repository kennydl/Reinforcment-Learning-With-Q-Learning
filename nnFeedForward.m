function Q = nnFeedForward(nn_params, ...
                            input_layer_size, ...
                            hidden_layer_size, ...
                            output_layer_size, ...
                            inputs)

    % Weight matrices of the Neural Network
    w1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
        hidden_layer_size, (input_layer_size + 1));

    w2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
        output_layer_size, (hidden_layer_size + 1));
    
    % Scale sensor values
    inputs = inputs./100;
    L1 = [1; inputs'];              %Layer 1 (Input layer) 

    z2 = w1*L1;
    L2 = [1; tanhActivation(z2)];   %Layer 2(Hidden layer)

    z3 = w2*L2;
    Q = tanhActivation(z3);         %Layer 3(Output layer)

end