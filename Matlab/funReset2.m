function funReset2(object_handle, event, start_button2, pause_button2, save_button2)
    
    global mode
    mode = 'Reset2';
    
    set(start_button2, 'BackGroundColor', 'g', 'Enable', 'on');   
    set(pause_button2, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    set(object_handle, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    
    set(save_button2, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    
    
end