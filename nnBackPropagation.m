function [C, grad] = nnBackPropagation(nn_params, input_layer_size, ...
                                    hidden_layer_size, output_layer_size, ...
                                    actions, sensor, a, Q_est)

    w1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
        hidden_layer_size, (input_layer_size + 1));

    w2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
        output_layer_size, (hidden_layer_size + 1));

    C = 0;
    w1_grad = zeros(size(w1));
    w2_grad = zeros(size(w2));
    n_actions = length(actions);
    I = eye(n_actions);

    % Input layer
    inputs = sensor;
    x = inputs./100;    % Scale the input data between 0 and 1   

    % Feed forward
    L1 = [1; x'];
    z2 = w1*L1;
    L2 = [1; tanhActivation(z2)];

    z3 = w2*L2;
    Q = tanhActivation(z3);
    
    % cost-function C
    C = (1/2)*( Q_est - Q(a) ).^2;
    
    % Back propagation
    %delta_3 = -(Q_est - Q(a)).*I(:,a);
    delta_3 = (Q(a) - Q_est).*I(:,a);
    %delta_3 = (-(Q_est - Q(a)).*I(:,a)).*tanhDerivative(z3);    % Layer 3
   
    temp = (w2'*delta_3).*tanhDerivative([1;z2]);
    delta_2 = temp(2:end);                                       % Layer 2

    w1_grad = delta_2*L1';  % Partial derivate with respect to the weights between layer 1 and 2
    w2_grad = delta_3*L2';  % Partial derivate with respect to the weights between layer 2 and 3

    grad = [w1_grad(:) ; w2_grad(:)];
    
end
