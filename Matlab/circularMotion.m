function circularMotion(point, patch, theta)

    %Roter de dynamiske hindringene
    for i = 1:length(patch)
        
        rotate(patch(i), [0,0,1], theta*180/pi, [point,0]);     
    end
    
end