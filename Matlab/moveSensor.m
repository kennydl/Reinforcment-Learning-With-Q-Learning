function moveSensor(speed, rot_punkt, tot_rot, theta, patch)
    
    
    n_patch = length(patch);
    
    % Loop through all sensors
    for i = 1:n_patch
        
        Points = get(patch(i),'Vertices');  
        r = ones(size(Points));    
        r = [speed*cos(tot_rot)*r(:,1), speed*sin(tot_rot)*r(:,2)] + Points(:,1:2);
        set(patch(i), 'XData', r(:,1), 'YData', r(:,2)); 
        rotate(patch(i),[0,0,1], theta*180/pi, [rot_punkt,0]);        
    end
    
end
