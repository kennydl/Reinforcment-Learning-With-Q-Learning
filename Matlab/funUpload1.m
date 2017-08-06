function funUpload1(object_handle, event)

    global mode;
    global figure1;
    
    mode = 'Upload1';
    figure1 = true;
    
    set(object_handle, 'BackGroundColor', [0.4,0.4,0.4], 'Enable', 'off');
    
end