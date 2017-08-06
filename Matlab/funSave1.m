function funSave1(object_handle, event)

    global mode;
    
    mode = 'Save1';
    
    set(object_handle, 'BackGroundColor', [0, 1, 1], 'Enable', 'off');
    
end