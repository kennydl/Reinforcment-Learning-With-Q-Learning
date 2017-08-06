function [h_polygons, h_circles] = createStadium(mode)
    
    %% ----- Initialize the obstacles and the arena

    if( strcmp(mode,'Static') )
        
        obs = [];
        h_polygons = [];
        h_circles = [];

        %Properties of the arena
        arena_r = 25;                           %The arena radius
        [X,Y] = circle([0, 0], arena_r, 1000);       
        arena = patch(X,Y,'w');                    

        % Properties of the obstacles
        n_points = 20;                          %number of points the obstacles are divided into       
        %Offset of the origo (0,0)
        offs = 11;                  

        % Radius of the circle obstacles    
        radius = [2.5, 2.5, 4.5, 2.5];

        % Origo of each circle obstacles 
        centre = [offs+2, 8; ...
                -offs+1, -offs+1; ...
                0, 25; -2, 13];


        % Create the circle obstacles
        n_circles = size(centre,1);             %number of obstacles
        for i = 1:n_circles            
            [X, Y] = circle(centre(i,:), radius(i), n_points);                             
            obs(i) = patch(X, Y, 'r');                              
        end

        %check if there already exists circle obstacles
        if( ~isempty(obs))                  
            h_circles = [obs, arena];   

        % Set h_circles equal the arena no circle obstacles exists
        elseif( isempty(obs) )
            h_circles = arena;

        end

        %square = [10, 0; 15, -4; 15, 4; 10, 2];
        %square1 = [10, -22.9; 15, -20; 8, -11.38; 3, -14.28];
        %square1 = [16, -19.21; 18, -17.35; 13, -11.97; 11, -13.83];
        %square1 = [17, -18.33; 19, -16.25; 12, -9.52; 10, -11.6];
        %triangle1 = [16, -19.21; 18, -17.35; 13, -13.923];
        triangle1 = [10, -22.9; 15, -20; 7, -11.967];
        square2 = [-24.92, 2; -24.92, -2; -15, -2; -15, 2];

        %sq1 = patch(square1(:,1), square1(:,2), 'g');
        tri1 = patch(triangle1(:,1), triangle1(:,2), 'g');
        sq2 = patch(square2(:,1), square2(:,2), 'g');

        h_polygons = [tri1, sq2];
        
    
    elseif( strcmp(mode,'Dynamic') )
        
        obs = [];
        h_polygons = [];
        h_circles = [];

        arena_r = 25;                               
        [X,Y] = circle([0, 0], arena_r, 1000);      
        arena = patch(X,Y,'w');                            
        n_points = 20;                          
        offs = 11;                  
   
        %radius = [2.5, 2.5, 2.5, 5.5];
        radius = [1.8, 1.8, 1.8, 3.5, 1.8, 1.8];
        centre = [0, norm([offs,offs]); ...
                -offs, -offs;  ...
                offs, -offs;  ...
                0, 25; -8, 0; 8, 0];

        n_circles = size(centre,1);    
        for i = 1:n_circles
            [X, Y] = circle(centre(i,:), radius(i), n_points);     
            obs(i) = patch(X, Y, 'r');                              
        end

        if( ~isempty(obs))                  
            h_circles = [obs, arena];   

        elseif( isempty(obs) )
            h_circles = arena;

        end

        %square = [10, 0; 15, -4; 15, 4; 10, 2];
        %square1 = [10, -22.9; 15, -20; 8, -11.38; 3, -14.28];
        %square1 = [16, -19.21; 18, -17.35; 13, -11.97; 11, -13.83];
        %square1 = [17, -18.33; 19, -16.25; 12, -9.52; 10, -11.6];
        triangle1 = [16, -19.21; 18, -17.35; 13, -13.923];
        %triangle1 = [10, -22.9; 15, -20; 7, -11.967];
        %square2 = [-24.92, 2; -24.92, -2; -19, -2; -19, 2];
        square2 = [-24.92, 2; -24.92, -2; -18, -2; -18, 2];
        
        %sq1 = patch(square1(:,1), square1(:,2), 'g');
        tri1 = patch(triangle1(:,1), triangle1(:,2), 'g');
        sq2 = patch(square2(:,1), square2(:,2), 'g');

        h_polygons = [tri1, sq2];        
    end     
end