function tot_rot = doActionCircle(action, wheel_radius, dist_between_wheels, tot_rot, h_car)

    % Function for moving the vehicle in the simulation

    R = wheel_radius;
    B = dist_between_wheels;
    c = 1.4;
    b = 1;
    a = action;
    
    switch(a)
        
        % Move forward
        case 1
            w_r = c*(0.15*(2*pi));       %rad/per sec
            w_l = c*(0.15*(2*pi));       %rad/per sec
        
        % Turn left    
        case 2
            w_r = 0;
            w_l = b*0.15*(2*pi);        %rad/per sec
        
        % Turn right
        case 3
            w_r = b*0.15*(2*pi);        %rad/per sec
            w_l = 0;
    end

    v = (1/2)*R*(w_r + w_l);            % Velocity
    theta = (1/(2*B))*(w_r - w_l);      % Angular rotaion
    tot_rot = tot_rot + theta;          % Total rotation

    rot_punkt = moveCarCircle(v, tot_rot, theta, h_car(1));
    moveSensor(v, rot_punkt, tot_rot, theta, h_car(2:end)); 
end