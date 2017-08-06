function [x, y] = circle(senter, radius, n_points)
    
	%Funksjon brukes til å lage sirkler ved å bruke polarkoordinater

    s = senter;
    r = radius;
    n = n_points;

    theta = linspace(0,2*pi, n);
    rho = ones(1, n)*r;
    [x, y] = pol2cart(theta, rho);
    x = x + s(1);
    y = y + s(2);
    
    
end