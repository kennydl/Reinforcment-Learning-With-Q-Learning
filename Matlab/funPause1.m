function funPause1(object_handle, event, start_button1, reset_button1, start_button2,...
                        pause_button2, reset_button2, upload_button1, save_button1, upload_button2, save_button2)
    
    global mode
    global figure2;
    mode = 'Pause1';
    
    set(start_button1, 'BackGroundColor', 'g', 'Enable', 'on');
    set(object_handle, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off'); 
    set(reset_button1, 'BackGroundColor', 'r', 'Enable', 'on');
    
    set(start_button2, 'Visible', 'on', 'Enable', 'on');
    set(pause_button2, 'Visible', 'on', 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    
    if(figure2) 
        set(save_button2, 'BackGroundColor', 'y', 'Enable', 'on', 'Visible', 'on');
        set(reset_button2, 'Visible', 'on', 'BackGroundColor', 'r', 'Enable', 'on');
        
    else
        set(save_button2, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off', 'Visible', 'on');
        set(reset_button2, 'Visible', 'on', 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    end
    
    set(upload_button1, 'BackGroundColor', 'y', 'Enable', 'on');
    set(save_button1, 'BackGroundColor', 'y', 'Enable', 'on');
    
    set(upload_button2, 'BackGroundColor', 'y', 'Enable', 'on', 'Visible', 'on');
    
    
end