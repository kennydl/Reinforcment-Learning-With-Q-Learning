function funStart2(object_handle, event, start_button1, pause_button1, reset_button1, pause_button2,... 
                    reset_button2, upload_button1, save_button1, upload_button2, save_button2)
    
    global mode;
    global figure2;
    mode = 'Start2';
    
    set(start_button1, 'Visible', 'off', 'Enable', 'off');
    set(pause_button1, 'Visible', 'off', 'Enable', 'off');
    set(reset_button1, 'Visible', 'off', 'Enable', 'off');
    set(upload_button1, 'Visible', 'off', 'Enable', 'off');
    set(save_button1, 'Visible', 'off', 'Enable', 'off');
    
    if(figure2 == false)
        
        set(object_handle, 'BackGroundColor', [0,1,1], 'Enable', 'off');
        set(pause_button2, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
        set(reset_button2, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
         
    else
       
        set(object_handle, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
        set(pause_button2, 'BackGroundColor', 'b', 'Enable', 'on');
        set(reset_button2, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off'); 
        
    end

    set(upload_button2, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    set(save_button2, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
     
    disp('Neural Network Start!');
    
end