function funReset1(object_handle, event, start_button1, pause_button1, save_button1)
    
    global mode
    mode = 'Reset1';
    
    set(start_button1, 'BackGroundColor', 'g', 'Enable', 'on');
    set(object_handle, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    set(pause_button1, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    
    set(save_button1, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    
end