function [sensor_value, crash] = sensorValues(sensor_vertices, obstacle, shape, dist_crash)

    %Funksjon til å finne avstanden mellom agent og hindringer via sensorer

    crash = false;

    P = obstacle;                   %hindringer
    Qx = sensor_vertices(:,1);      %x-punktene til sensor
    Qy = sensor_vertices(:,2);      %y-punktene til sensor
    sensor_value = norm([Qx(end) - Qx(1), Qy(end) - Qy(1)]);    %lengden på sensoren

    Qx_min = min(Qx);               
    Qx_max = max(Qx);

    Qy_min = min(Qy);
    Qy_max = max(Qy);

    n_points = 7000;
    x = linspace(Qx_min, Qx_max, n_points)';    %Lager en x-vektor med 7000 punkter
    y = linspace(Qy_min, Qy_max, n_points)';    %Lager en y-vektor med 7000 punkter
    n_x = length(x);        
    dist_between = 0.2;     %lengde mellom sensor og hindring

    %Beregne ligningen for sensoren (Rett linje)
    b = Qy(end)- Qy(1);
    c = Qx(end)- Qx(1);

    if( c ~= 0 )
        a = b/c;                        %Stigningstall
        y = a.*(x - Qx(1)) + Qy(1);     
    else
        n_points = length(y);
        x = Qx(1).*ones(n_points,1);
    end

    %Sirkel hindring
    if( strcmp(shape,'circle') )
        
        a = (min(P(:,1)) + max(P(:,1)))/2;
        b = (min(P(:,2)) + max(P(:,2)))/2;

        centre = [a, b];
        radius = norm([P(1,1) - centre(1), P(1,2) - centre(2)] );

        %Beregne sirkel funksjonene til hindringen P
        f1 =  sqrt( radius.^2 - (x - a).^2 ) + b;
        f2 = -sqrt( radius.^2 - (x - a).^2 ) + b;
        
        %Sjekker differansen mellom sensorens funksjon y og hindringens funksjon f
        g1 = abs(y - f1);
        g2 = abs(y - f2);
        
        %Dersom differansen er mindre enn dist_between gir sensoren utslag
        I1 = find( g1 < dist_between);
        I2 = find( g2 < dist_between);
        I = [I1; I2];
          
        if( ~isempty(I) )
            
            %Beregne sensorverdien
            sensor_value = min(dist([x(I), y(I)], [Qx(1); Qy(1)]));
            
            %Krasj dersom sensor verdien gir mindre enn dist_crash
            if(sensor_value < dist_crash)

                crash = true;
            end

        end

    %Hindring av mangekanter
    elseif( strcmp(shape,'polygon') )

        n_punkter = size(P,1);
        
        %Finne funksjonene f(x) = a*(x-x0) + f(x0) for kantene av hindringen
        for i = 1:n_punkter-1
  
            f = ones(n_x,1);
            g = ones(n_x,1);
            b = P(i+1, 2) - P(i, 2);
            c = P(i+1, 1) - P(i, 1);

            if( c ~= 0 )

                a = b/c;

                x_limit1 = min([P(i,1), P(i+1,1)]);     %x-min grense
                x_limit2 = max([P(i,1), P(i+1,1)]);     %x-maks grense

                %begrense x-verdiene til å ligge mellom x-min og x-maks
                I = (x_limit1 < x) & (x < x_limit2);    

                f(I) = a.*(x(I) - P(i,1)) + P(i,2);     %funksjonen f(x)
                g(I) = abs(y(I) - f(I));                %diffensen mellom y og f(x)

            else

                y_limit1 = min([P(i,2), P(i+1,2)]);     %y-min grense
                y_limit2 = max([P(i,2), P(i+1,2)]);     %y-maks grense
            
                %begrense y-verdiene til å ligge mellom y-min og y-maks
                I = (y_limit1 < y) & (y < y_limit2);
                
                %differansen mellom agentens x-punkter og x-punktene til hindringen
                g(I) = abs( x(I) - P(i,1) );            

            end
            
            %Sjekke om g har noen verdier under dist_between
            I = find( g < dist_between);
            
            if( ~isempty(I) )
                
                temp = min(dist([x(I), y(I)], [Qx(1); Qy(1)]));
                
                if(sensor_value > temp)
                    
                    sensor_value = temp;        %finne minste sensorverdien mellom agenten og kantene av hindringen               
                end

                if(sensor_value < dist_crash)

                    crash = true;
                end
            end

        end
        
        %Samme metode som for løkka over, men nå for siste kanten av hindringen 
        f = ones(n_x,1);
        g = ones(n_x,1);
        b = P(n_punkter, 2) - P(1, 2);
        c = P(n_punkter, 1) - P(1, 1);

        if(c ~= 0)

            a = b/c;

            x_limit1 = min([P(1,1), P(n_punkter,1)]);
            x_limit2 = max([P(1,1), P(n_punkter,1)]);

            I = (x_limit1 < x) & (x < x_limit2) ;

            f(I) = a*( x(I) - P(1,1)) + P(1,2);
            g(I) = abs(y(I) - f(I));


        else

            y_limit1 = min([P(1,2), P(n_punkter,2)]);
            y_limit2 = max([P(1,2), P(n_punkter,2)]);

            I = (y_limit1 < y) & (y < y_limit2) ;
            g(I) = abs( x(I) - P(1,1) );
        end

        I = find( g < dist_between);

        if( ~isempty(I) )

            temp = min(dist([x(I), y(I)], [Qx(1); Qy(1)]));
            
            if( sensor_value > temp)
                
                sensor_value = temp;
            end
            
            if(sensor_value < dist_crash)

                crash = true;
            end
        end
    end
    
end