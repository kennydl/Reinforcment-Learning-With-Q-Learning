function h = createCarCircle(radius, sensor_lengde, color)
     
    [X,Y] = circle([0, 0], radius, 100);                        
    car = patch(X,Y, color);                                   
    set(car,'FaceLighting','phong','EdgeLighting','phong');
    
    %car = patch(P_bil(:,1),P_bil(:,2), 'r'); 
    % Sensor properties
    n_punkter = 2;              % Number of points of the sensors

    %x-aksen for de 5 forskjellige sensor-linjene
    x1 = linspace(radius, sensor_lengde + (radius), n_punkter);             %middle sensor. 0 grader       
    x2 = linspace(radius, sensor_lengde*cos(pi/4) + radius, n_punkter);     %the two sensors close to middle. pi/4 radianer
    x3 = linspace(radius, sensor_lengde*cos(pi/8) + radius, n_punkter);     %the two farthest sensors. pi/8 radianer
    
    for i = 1:n_punkter
        
        % Equations for straight lines (y-aksen)
        y1(i) = tan(pi/4)*(x2(i) -radius);      
        y2(i) = tan(pi/8)*(-radius + x3(i));
        y3(i) = 0; 
        y4(i) = tan(pi/8)*(radius - x3(i));
        y5(i) = tan(pi/4)*(radius - x2(i));
        
    end

    % Create sensors
    L_h1 = patch(x2', y1', 'k');
    L_h2 = patch(x3', y2', 'k');
    L_h3 = patch(x1', y3', 'k');
    L_h4 = patch(x3', y4', 'k');
    L_h5 = patch(x2', y5', 'k');

    h = [car ,L_h1, L_h2, L_h3, L_h4, L_h5];    
end