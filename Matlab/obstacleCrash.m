function crash = obstacleCrash(car, obstacle, shape)
    
    %Funksjon til å sjekke crash mellom agenten og hindringene(ikke sensorer)

	crash = false;
    
	P = obstacle;           %hindring
	x = car(:,1);           %x-punktene til agenten
	y = car(:,2);           %y-punktene til agenten
    dist_between = 0.3;
    
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
		g1 = abs(y-f1);
		g2 = abs(y-f2);
        
        %Dersom differansen er mindre enn dist_between gir sensoren utslag
        if( ~isempty(find( g1 < dist_between, 1)) || ~isempty(find( g2 < dist_between, 1)) )
            
            crash = true;
        end

    %Hindring av mangekanter
    elseif( strcmp(shape,'polygon') )

		n_punkter = size(P,1);
        
        %Finne funksjonene f(x) = a*(x-x0) + f(x0) for kantene av hindringen
        for i = 1:n_punkter-1
            
            g = [];
            b = P(i+1, 2) - P(i, 2);
            c = P(i+1, 1) - P(i, 1);
            
            if( c ~= 0 )
            
                a = b/c;

                x_limit1 = min([P(i,1), P(i+1,1)]);         %x-min grense
                x_limit2 = max([P(i,1), P(i+1,1)]);         %x-maks grense
                
                %begrense x-verdiene til å ligge mellom x-min og x-maks
                I = find((x_limit1 < x) & (x < x_limit2) );   
                
                if( ~isempty(I) )
                    
                    f = a.*(x(I) - P(i,1)) + P(i,2);        %funksjonen f(x)
                    g = abs(y(I) - f);                      %diffensen mellom y og f(x)
                end

            else
                
                y_limit1 = min([P(i,2), P(i+1,2)]);         %y-min grense
                y_limit2 = max([P(i,2), P(i+1,2)]);         %y-maks grense
                
                %begrense y-verdiene til å ligge mellom y-min og y-maks
                I = find( (y_limit1 < y) & (y < y_limit2) );    
                
                if( ~isempty(I) )
                    
                    %differansen mellom agentens x-punkter og x-punktene til hindringen
                    g = abs( x(I) - P(i,1) );
                end
                
            end
			
            %Sjekke om g har noen verdier under dist_between
            if( ~isempty(find( g < dist_between, 1)) )
                    
                crash = true;
                return;
            end
            
        end
        
        %Samme metode som for løkka over, men nå for siste kanten av hindringen
        g = [];
        b = P(n_punkter, 2) - P(1, 2);
        c = P(n_punkter, 1) - P(1, 1);
        
        if(c ~= 0)
            
            a = b/c;
            
            x_limit1 = min([P(1,1), P(n_punkter,1)]);
            x_limit2 = max([P(1,1), P(n_punkter,1)]);
            
            I = find((x_limit1 < x) & (x < x_limit2) );
            
            if( ~isempty(I) )
                
                f = a*( x(I) - P(1,1)) + P(1,2);
                
                g = abs(y(I) - f);
            end
                    
        else      
            
            y_limit1 = min([P(1,2), P(n_punkter,2)]);
            y_limit2 = max([P(1,2), P(n_punkter,2)]);m
            
            I = find( (y_limit1 < y) & (y < y_limit2) );
            
            if( ~isempty(I) )
                
                g = abs( x(I) - P(1,1) );
            end
            
        end
        
        if( ~isempty(find( g < dist_between, 1)) )

			crash = true;
        end
    end
end