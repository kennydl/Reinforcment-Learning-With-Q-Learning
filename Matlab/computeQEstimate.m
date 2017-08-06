function Q_est = computeQEstimate(nn_params, input_layer_size, hidden_layer_size, ...
                                output_layer_size, sensor, reward, gamma)
    
    %Funksjonen beregner Q esitmiatet som videre brukes til å trene det nevrale nettverket                  
                
    Q_neste = nnFeedForward(nn_params, input_layer_size, hidden_layer_size, ...
                          output_layer_size, sensor);
         
    Q_est = reward + gamma*max(Q_neste);
    
end