function [sensor, crash] = checkCrash(car, obstacle_polygon, obstacle_circle)
    
    %% ----- Initialization

    A = get(car(1),'Vertices');     %Get vertices of the vehicle
    dist_crash = 1.5;               %Sensor distance (1.5 = 15cm) for crash
    obs_crash = false;              %Obstacle crash
    sens_crash = false;             %Crash sensor values are below 1.5.
    status = true;                  %Help variable

    %% ----- Check collision between the vehicle and obstacles
    
    n_polygons = length(obstacle_polygon);
    n_circles = length(obstacle_circle);
    for i = 1:n_polygons

        B = get(obstacle_polygon(i),'Vertices');

        obs_crash = obstacleCrash(A, B, 'polygon');

        if(obs_crash)
            status = false;
            break;
        end

    end

    if(status)

        for i = 1:n_circles

            C = get(obstacle_circle(i),'Vertices');

            obs_crash = obstacleCrash(A, C, 'circle');

            if(obs_crash)
                break;
            end
        end
    end

    %% ----- Check collision with sensors
    
    n_sensors = length(car(2:end));
    sensor = zeros(1, n_sensors);
    
    % Loop through the sensors
    for i = 1:n_sensors
        
        % Get vertices of the sensors
        D = get(car(i+1),'Vertices');
        sensor_temp = 0;
        
        % For each sensor, check collision with all the obstacles
        for j = 1:n_circles
            
            C = get(obstacle_circle(j), 'Vertices');
            
            % Store all the sensor values in a vector
            [sensor_temp(j), crash] = sensorValues(D, C, 'circle', dist_crash);
            
            % Check collision
            if(crash)
                sens_crash = true;
                break;
            end
        end

        if( ~sens_crash )

            for k = (j+1):(j + n_polygons)

                B = get(obstacle_polygon(k-j), 'Vertices');

                [sensor_temp(k), crash] = sensorValues(D, B, 'polygon', dist_crash);

                if(crash)
                    
                    sens_crash = true;
                end
            end
        end
        
        % store the lowest sensor value
        sensor(i) = min(sensor_temp);

    end

    %sensor = round(10.*sensor);
    sensor = 10.*sensor;                % Scale the sensor values with 10
    crash = [obs_crash, sens_crash];    % Store the results in a vector
end