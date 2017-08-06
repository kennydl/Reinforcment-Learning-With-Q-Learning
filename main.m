
initSimulation;

%% ----- Main loop

while(true)
    
    pause(0.1);
    
    % Reset for Q-tabell metoden
    if( strcmp(mode,'Reset1') )
        
        mode = '';
        figure1 = true;
        i = 1;
        n1 = 1;
        x1 = 0;
        y1 = 0;
        y2 = 0;
        steps1 = 0;
        n_steps1 = 0;
        reward1 = 0;
        total_reward1 = 0;
        n_crash1 = 0;
        T1 = 24;
        
        Q_table = createQTable(n_states, n_actions);
        
        cla(h_plot1(2));
        cla(h_plot1(3));
    end
    
    
    if( strcmp(mode,'Upload1') )
        
        mode = '';
        
        if( exist('Q-Table_upload_static.mat', 'file') >= 1 || exist('Q-Table_upload_dynamic.mat', 'file') >= 1 )
            
            if(strcmp(stadium_option1,'Static') == 1), load('Q-Table_upload_static.mat');
                
            elseif(strcmp(stadium_option1,'Dynamic') == 1), load('Q-Table_upload_dynamic.mat');
                
            end
            
            subplot(h_plot1(2));
            plot(x1,y1);

            subplot(h_plot1(3));
            plot(x1,y2);

            i = i + 1;
            T1 = 1.0e-3;
            
        end
        
    end
    
    if( strcmp(mode,'Save1') )
        
        mode = '';
        
        % Store pamaterers
        save('Q_Table_savefile.mat', 'Q_table', 'i', 'n1', 'x1', 'y1', 'y2', 'steps1', 'n_steps1',...
            'reward1', 'total_reward1', 'n_crash1','tot_steps1');
        
        % Store MATLAB figure
        savefig('Q_table_fig');
        
        % Store Q-table
        fil = fopen('Q-tabell&stateSpace.txt','w');
        fprintf(fil, '%25s%34s\n','Q-tabell', 'State Space');
        
        if( strcmp(stadium_option1,'Static') == 1)
            fprintf(fil, '%10s%10s%10s\t\t%5s%5s%5s%5s\n','Q1', 'Q2', 'Q3', 'k1', 'k2', 'k3', 'k4');
            fprintf(fil,'%10.2f%10.2f%10.2f\t\t%5.f%5.f%5.f%5.f\n', cat(2,Q_table,state_space)');
            
        elseif(strcmp(stadium_option1,'Dynamic') == 1)
            fprintf(fil, '%10s%10s%10s\t\t%5s%5s%5s%5s%5s%5s\n','Q1', 'Q2', 'Q3', 'k1', 'k2', 'k3', 'k4', 'k5', 'k6');
            fprintf(fil,'%10.2f%10.2f%10.2f\t\t%5.f%5.f%5.f%5.f%5.f%5.f\n', cat(2,Q_table,state_space)');
        end
        fclose(fil);
        
        set(h_button1(5), 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
        
        break;
    end
    
    
    %Reset for Neural Network 
    if( strcmp(mode,'Reset2') )
        
        mode = '';
        figure2 = true;
        j = 1;
        n2 = 1;
        x2 = 0;
        y3 = 0;
        y4 = 0;
        steps2 = 0;
        n_steps2 = 0;
        reward2 = 0;
        total_reward2 = 0;
        n_crash2 = 0;
        T2 = 24;
        
        initial_w1 = randInitializeWeights(input_layer_size, hidden_layer_size);
        initial_w2 = randInitializeWeights(hidden_layer_size, output_layer_size);
        nn_params = [initial_w1(:); initial_w2(:)];
        
        cla(h_plot2(2));
        cla(h_plot2(3));
        
    end
    
    if( strcmp(mode,'Upload2') )
        
        mode = '';
        
        if( exist('NN_upload_static.mat', 'file') >= 1 || exist('NN_upload_dynamic.mat', 'file') >= 1 )
            
            if(strcmp(stadium_option2,'Static') == 1), load('NN_upload_static.mat');                
            elseif(strcmp(stadium_option2,'Dynamic') == 1), load('NN_upload_dynamic.mat');
            end
            
            load('NN_uploadfile.mat');
            
            subplot(h_plot2(2));
            plot(x2,y3);
            
            subplot(h_plot2(3));
            plot(x2,y4);
            
            j = j + 1;
            T2 = 1.0e-3;
            
        end
    end
    
    if( strcmp(mode,'Save2') )
        
        mode = '';
        
        weight1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
            hidden_layer_size, (input_layer_size + 1));
        
        weight2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
            output_layer_size, (hidden_layer_size + 1));
        
        % Store paramters
        save('NN_savefile.mat', 'nn_params', 'weight1', 'weight2', 'j', 'n2', 'x2', 'y3', 'y4', 'steps2', 'n_steps2',...
            'reward2', 'total_reward2', 'n_crash2','tot_steps2','cost_fun');
        
        % Store MATLAB figure
        savefig('nn_fig');
        
        % Store weight matrices
        fil = fopen('nnWeights.txt','w');
        fprintf(fil, '\n%30s\n','Weight1');
        
        fprintf(fil, '%8s%8s%8s%8s%8s%8s\n','w0', 'w1', 'w2', 'w3', 'w4', 'w5');
        fprintf(fil,'%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f\n', weight1');
        
        fprintf(fil, '\n\n%65s\n','Weight2');
        fprintf(fil, '%8s%8s%8s%8s%8s%8s%8s%8s%8s%8s%8s%8s%8s%8s%8s%8s\n',...
            'w0', 'w1', 'w2', 'w3', 'w4', 'w5', 'w6','w7', 'w8', 'w9', 'w10', 'w11', 'w12', 'w13', 'w14', 'w15');
        fprintf(fil, '%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f\n', weight2');
        
        fclose(fil);
        
        clear('weight1', 'weight2');
        set(h_button2(5), 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
        
    end
    
    
    % Main loop for Q-table method
    if( strcmp(mode,'Start1') )
        
        mode = '';
        info_s1 = sprintf('%s%11d%21s%13d%22s%10.2f', 'Trials:', i-1, 'Steps:', steps1, 'Total reward:', reward1);
        
        for i = i:max_trials
            
            subplot(h_plot1(1));
            
            [Q_table, reward1, steps1, n_crash1, info_s2] = tableTrials(Q_table, alpha1, gamma, T1, ...
                                                            stadium_option1, h_car1, h_circ1, h_poly1, state_space, actions, ...
                                                            max_steps, n_crash1, radius, wheel_radius, info_s1, h_text1);
            
            subplot(h_plot1(1));
            delete(h_car1);
            h_car1 = createCarCircle(radius, sensor_lengde, 'b');
            drawnow;
            
            if( strcmp(mode,'Pause1') ), break; end
            if(T1 > 1.0e-3), T1 = 0.95*T1; end
            
            
            info_s1 = sprintf('%s%11d%21s%13d%22s%10.2f', 'Trials:', i, 'Steps:', steps1, 'Total reward:', reward1);
            info_s = sprintf('%s\n%s', info_s1, info_s2);
            set(h_text1, 'String', info_s);
            
            n_steps1 = n_steps1 + steps1;
            tot_steps1 = tot_steps1 + steps1;
            total_reward1 = total_reward1 + reward1;
            
            if( mod(i,10) == 0)
                
                n1 = n1 + 1;
                x1(n1) = n1-1;
                y1(n1) = n_steps1/10;
                y2(n1) = total_reward1;
                
                subplot(h_plot1(2));
                plot(x1,y1);
                xlabel('Trials x10');
                ylabel('Average steps each 10th trials');    
                
                subplot(h_plot1(3));
                plot(x1,y2);
                title('Total reward');
                xlabel('Trials x10');
                ylabel('Accumulated reward');
                
                n_steps1 = 0;
                subplot(h_plot1(1));
                drawnow;
            end
            
            if( i == 300 && ~figure1)
                
                set(h_button1(1), 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
                set(h_button1(2), 'BackGroundColor', 'b', 'Enable', 'on');
                %drawnow;
                figure1 = true;
            end
            
            if(mod(i,50) == 0), clc; end
            Tekst = sprintf('Trials: %d\nSteps: %d', i, steps1);
            fprintf([Tekst,'\n']);            
        end
        
    % Main loop for Neural Network method
    elseif( strcmp(mode,'Start2') )
        
        mode = '';
        info_s1 = sprintf('%s%11d%21s%13d%22s%10.2f', 'Trials:', j-1, 'Steps:', steps2, 'Total reward:', reward2);
        
        for j = j:max_trials
            
            subplot(h_plot2(1));
            
            [nn_params, Q_nn, Q_est, reward2, steps2, n_crash2, cost, info_s2] = ...
                                                        nnTrials(nn_params, input_layer_size, hidden_layer_size,...
                                                        output_layer_size, alpha2, gamma, T2, actions, max_steps,...
                                                        n_crash2, stadium_option2, h_car2, h_poly2, h_circ2, radius, wheel_radius, info_s1, h_text2);
            
            subplot(h_plot2(1));
            delete(h_car2);
            h_car2 = createCarCircle(radius, sensor_lengde, 'b');
            drawnow;
            
            if( strcmp(mode,'Pause2') ), break; end
            if(T2 > 1.0e-3), T2 = 0.95*T2; end
            
            info_s1 = sprintf('%s%11d%21s%13d%22s%10.2f', 'Trials:', j, 'Steps:', steps2, 'Total reward:', reward2);
            info_s = sprintf('%s\n%s', info_s1, info_s2);
            set(h_text2, 'String', info_s);
            
            n_steps2 = n_steps2 + steps2;
            tot_steps2 = tot_steps2 + steps2;
            total_reward2 = total_reward2 + reward2;
            cost_fun(j) = cost;
            
            if( mod(j,10) == 0)
                
                n2 = n2 + 1;
                x2(n2) = n2-1;
                y3(n2) = n_steps2/10;
                y4(n2) = total_reward2;
                
                subplot(h_plot2(2));
                plot(x2,y3);
                xlabel('Trials x10');
                ylabel('Average steps each 10th trials');  
                
                subplot(h_plot2(3));
                plot(x2,y4);
                title('Total reward');
                xlabel('Trials x10');
                ylabel('Accumulated reward');
                
                n_steps2 = 0;
                subplot(h_plot2(1));
                drawnow;
            end
            
            if(j == 300 && ~figure2)
                
                set(h_button2(1), 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
                set(h_button2(2), 'BackGroundColor', 'b', 'Enable', 'on');
                figure2 = true;
            end
            
            if(mod(j,50) == 0), clc; end
            Tekst = sprintf('Trials: %d', j);
            fprintf([Tekst,'\n']);            
        end
    end 
end

