function w = gradientDescent( nn_params, w_grad, alpha, num_iters, ...
                                          input_layer_size, ...
                                          hidden_layer_size, ...
                                          output_layer_size)       
                                                    
    % Weight matrices of the Neural Network                                               
    w1 = reshape(nn_params(1:hidden_layer_size*(input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
    
    w2 = reshape(nn_params((1 + (hidden_layer_size*(input_layer_size + 1))):end), ...
                 output_layer_size, (hidden_layer_size + 1));

    % Partial derivatives
    w1_grad = reshape(w_grad(1:hidden_layer_size*(input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

    w2_grad = reshape(w_grad((1 + (hidden_layer_size*(input_layer_size + 1))):end), ...
                 output_layer_size, (hidden_layer_size + 1));
         
    % Update weight matrices
    for iter = 1:num_iters
        
        w1 = w1 - alpha.*w1_grad;   
        w2 = w2 - alpha.*w2_grad;       
    end
           
    w = [w1(:); w2(:)];

end