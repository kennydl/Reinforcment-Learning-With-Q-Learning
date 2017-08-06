function [h_plot1, h_plot2, h_text1, h_text2, h_button1, h_button2] = createSimulation(xlimit, ylimit, max_trials, max_steps,... 
                                                                                        alpha1, alpha2, gamma, epsilon, T)
    %% ----- GUI for simuleringen
                                                                                    
    close all;
    
    figure('Position', [350, 60, 1050, 850]); 
    h_tab = uitabgroup; 

    %% ----- Tab 1: Q-Table
    
    tab1 = uitab(h_tab, 'title', 'Q-table');

    QTable_panel = uipanel(tab1, 'title', 'Q-table method');

    plot1 = axes('parent', QTable_panel,'XLim', xlimit, 'YLim', ylimit,'Box', 'on', ...
                'Position', [0.06, 0.57, 0.4, 0.4]);

    plot2 = axes('parent', QTable_panel, 'Box', 'on', ...
                'Position', [0.56, 0.57, 0.4, 0.4]);

    plot3 = axes('parent', QTable_panel, 'Box', 'on', ...
                'Position', [0.06, 0.075, 0.4, 0.4]);        


    info_string1 = sprintf('%s%14d%20s%15d%24s%10.2f', 'Trials:', 0, 'Steps:', 0, 'Total reward:', 0);  
    info_string1 = sprintf('%s\n%s%10d%24s%8d%17s%10s', info_string1, 'l_zone:', 0,'l_sector:', 0, 'Action:', '');                 
    info_string1 = sprintf('%s\n%s%10d%24s%8d%14s%10d', info_string1, 'r_zone:', 0, 'r_sector:', 0, 'Crash:', 0);
                    
    tekst_panel1 = uipanel(QTable_panel, 'title', 'Informasjon','Position', [0.54, 0.39, 0.42, 0.1]);
    
    text1 = uicontrol(tekst_panel1, 'Style', 'text', 'HorizontalAlignment', 'left', ... 
                        'FontSize', 11, 'FontName', 'Calibri', 'String', info_string1, 'Position', [40, 0, 500, 60]);

    tekst_panel2 = uipanel(QTable_panel, 'title', 'Params','Position', [0.54, 0.04, 0.2, 0.30]);

    info_string2 = sprintf('%s%15d\n\n%s%13d\n\n%s%24.4f\n\n%s%21.4f\n\n%s%21.4f\n\n%s%8d',... 
                        'Maxtrials:', max_trials, 'Maxsteps:', max_steps,...
                        'alpha:', alpha1, 'gamma:', gamma, 'Epsilon:', epsilon, 'T(Soft-max):', T);

    uicontrol(tekst_panel2, 'Style', 'text', 'HorizontalAlignment', 'left', ... 
                        'FontSize', 11, 'FontName', 'Calibri', 'String', info_string2, 'Position', [20, 0, 200, 210]);                


    start_button1 = uicontrol(QTable_panel, 'Style', 'pushbutton', 'BackGroundColor', 'g', 'String', 'Start', 'Position', [800, 220, 90, 45]);
    
    pause_button1 = uicontrol(QTable_panel, 'Style', 'pushbutton', 'BackGroundColor', [0.4,0.4,0.4],...
                                'Enable', 'off', 'String', 'Pause', 'Position', [920, 220, 90, 45]);
                            
    upload_button1 = uicontrol(QTable_panel, 'Style', 'pushbutton', 'BackGroundColor', 'y',...
                                'Enable', 'on', 'String', 'Upload', 'Position', [800, 140, 90, 45]);
                            
    save_button1 = uicontrol(QTable_panel, 'Style', 'pushbutton', 'BackGroundColor', [0.4,0.4,0.4],...
                                'Enable', 'off', 'String', 'Save', 'Position', [920, 140, 90, 45]);
                            
    reset_button1 = uicontrol(QTable_panel, 'Style', 'pushbutton', 'BackGroundColor', [0.4,0.4,0.4],...
                                'Enable', 'off', 'String', 'Reset', 'Position', [855, 60, 100, 50]);
    

    %% ----- Tab 2: Neural Network
    
    tab2 = uitab(h_tab, 'title','Neural Network');

    NN_panel = uipanel(tab2, 'title', 'Neural Network method');

    plot4 = axes('parent', NN_panel, 'XLim', xlimit, 'YLim', ylimit,'Box', 'on', ...
                'Position', [0.06, 0.57, 0.4, 0.4]);

    plot5 = axes('parent', NN_panel, 'Box', 'on', ...
                'Position', [0.56, 0.57, 0.4, 0.4]);

    plot6 = axes('parent', NN_panel, 'Box', 'on', ...
                'Position', [0.06, 0.075, 0.4, 0.4]);        

    info_string3 = sprintf('%s%14d%20s%15d%24s%10.2f', 'Trials:', 0, 'Steps:', 0, 'Total reward:', 0);
    info_string3 = sprintf('%s\n%s%15.3f%17s%16.3f%14s%15.3f', info_string3, 'Q1:', 0.00000, 'Q2:', 0.000, 'Q3:', 0.000);                
    info_string3 = sprintf('%s\n%s%9.3f%20s%14d%15s%15.6f', info_string3, 'Q_est:', 0.000, 'Crash:', 0, 'cost:', 0.000000);
    
    
    tekst_panel3 = uipanel(NN_panel, 'title', 'Current Information','Position', [0.54, 0.39, 0.42, 0.1]);

    
    text2 = uicontrol(tekst_panel3, 'Style', 'text', 'HorizontalAlignment', 'left', ... 
                        'FontSize', 11, 'FontName', 'Calibri', 'String', info_string3, 'Position', [40, 0, 500, 60]);
    

                    
    tekst_panel4 = uipanel(NN_panel, 'title', 'Params','Position', [0.54, 0.032, 0.2, 0.31]);

    
    info_string4 = sprintf('%s%15d\n\n%s%13d\n\n%s%24.4f\n\n%s%21.4f\n\n%s%21.4f\n\n%s%8d',... 
                        'Maxtrials:', max_trials, 'Maxsteps:', max_steps,...
                        'alpha:', alpha2, 'gamma:', gamma, 'Epsilon:', epsilon, 'T(Soft-max):', T);

                    
    uicontrol(tekst_panel4, 'Style', 'text', 'HorizontalAlignment', 'left', ... 
                        'FontSize', 11, 'FontName', 'Calibri', 'String', info_string4, 'Position', [20, 0, 300, 215]);                


    start_button2 = uicontrol(NN_panel, 'Style', 'pushbutton', 'BackGroundColor', 'g', 'String', 'Start', 'Position', [800, 220, 90, 45]);
    
    pause_button2 = uicontrol(NN_panel, 'Style', 'pushbutton', 'BackGroundColor', [0.4,0.4,0.4],...
                                'Enable', 'off', 'String', 'Pause', 'Position', [920, 220, 90, 45]);
                            
    upload_button2 = uicontrol(NN_panel, 'Style', 'pushbutton', 'BackGroundColor', 'y',...
                                'Enable', 'on', 'String', 'Upload', 'Position', [800, 140, 90, 45]);
                            
    save_button2 = uicontrol(NN_panel, 'Style', 'pushbutton', 'BackGroundColor', [0.4,0.4,0.4],...
                                'Enable', 'off', 'String', 'Save', 'Position', [920, 140, 90, 45]);                        
                            
    reset_button2 = uicontrol(NN_panel, 'Style', 'pushbutton', 'BackGroundColor', [0.4,0.4,0.4],...
                                'Enable', 'off', 'String', 'Reset', 'Position', [855, 60, 100, 50]);
    
    %% ----- Callback functions
    
    set(start_button1, 'callback', {@funStart1, pause_button1, reset_button1, start_button2, pause_button2,... 
                                    reset_button2, upload_button1, save_button1, upload_button2, save_button2});
                                
    set(pause_button1, 'callback', {@funPause1, start_button1, reset_button1, start_button2, pause_button2,...
                                    reset_button2, upload_button1, save_button1, upload_button2, save_button2});
                                
    set(reset_button1, 'callback', {@funReset1, start_button1, pause_button1, save_button1});
    set(upload_button1, 'callback', @funUpload1);
    set(save_button1, 'callback', @funSave1);
    
    set(start_button2, 'callback', {@funStart2, start_button1, pause_button1, reset_button1, pause_button2,... 
                                    reset_button2, upload_button1, save_button1, upload_button2, save_button2});
    
    set(pause_button2, 'callback', {@funPause2, start_button1, pause_button1, reset_button1, start_button2,...
                                    reset_button2, upload_button1, save_button1, upload_button2, save_button2});
    
    
    set(reset_button2, 'callback', {@funReset2, start_button2, pause_button2, save_button2});
    set(upload_button2, 'callback', @funUpload2);
    set(save_button2, 'callback', @funSave2);
    
    %% ----- Headers
    h_plot1 = [plot1, plot2, plot3]; 
    h_plot2 = [plot4, plot5, plot6];
    h_text1 = text1;
    h_text2 = text2;
    h_button1 = [start_button1, pause_button1, reset_button1, upload_button1, save_button1];
    h_button2 = [start_button2, pause_button2, reset_button2, upload_button2, save_button2];

end