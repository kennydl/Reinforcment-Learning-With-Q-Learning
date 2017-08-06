function funStart1(object_handle, event, pause_button1, reset_button1, start_button2,...
                    pause_button2, reset_button2, upload_button1, save_button1, upload_button2, save_button2)
    
    global mode;
    global figure1;
    mode = 'Start1';
    
    set(start_button2, 'Visible', 'off', 'Enable', 'off');
    set(pause_button2, 'Visible', 'off', 'Enable', 'off');
    set(reset_button2, 'Visible', 'off', 'Enable', 'off');
    set(upload_button2, 'Visible', 'off', 'Enable', 'off');
    set(save_button2, 'Visible', 'off', 'Enable', 'off');
    
    if(figure1 == false)
        
        set(object_handle, 'BackGroundColor', [0,1,1], 'Enable', 'off');
        set(pause_button1, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
        set(reset_button1, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');     
          
    else
       
        set(object_handle, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
        set(pause_button1, 'BackGroundColor', 'b', 'Enable', 'on');
        set(reset_button1, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');

    end
    
     set(upload_button1, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
     set(save_button1, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
     

    disp('Q-Table Start!');
    
end