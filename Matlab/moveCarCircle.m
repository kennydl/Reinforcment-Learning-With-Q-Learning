function rot_punkt = moveCarCircle(velocity, tot_rot, theta, patch)
       
    P = get(patch,'Vertices');
    r = ones(size(P));

    r = P(:,1:2) + velocity.*[cos(tot_rot)*r(:,1), sin(tot_rot)*r(:,2)];
    set(patch, 'XData', r(:,1), 'YData', r(:,2));

    tot_rot = (min(P(:,1)) + max(P(:,1)))/2;
    b = (min(P(:,2)) + max(P(:,2)))/2;
    rot_punkt = [tot_rot, b];                 % center of the vehicle

    rotate(patch,[0,0,1], (theta*180)/pi, [rot_punkt,0]);
end
