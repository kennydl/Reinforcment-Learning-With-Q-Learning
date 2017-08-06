function funUpload2(object_handle, event)

    global mode;
    global figure2;
    
    mode = 'Upload2';
    figure2 = true;
    
    set(object_handle, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    
end