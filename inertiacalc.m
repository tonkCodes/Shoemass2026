% Masses (kg)
mMKnee = 2;
mMAnkle = 0.5;
mLUpper = 1.3;
mLCalf = 1;
mLFoot = 0.5;

% Lengths (m)
lCalf = 0.35;
lFoot = 0.2;
lUpper = 0.4572;

t = 0:0.1:10;
L1 = lUpper;
L2 = lCalf;
L3 = lFoot;
L = [L1 L2 L3];

theta0 = [-pi/2; -pi/4; -pi/2];
theta = theta0 + [(-pi/3)*sin(t);
                  (-pi/2)*sin(t);
                  (-pi/3)*sin(t)];

I = zeros(size(t));

figure(1)
for k = 1:length(t)
    xKnee = L1*cos(theta(1,k));
    yKnee = L1*sin(theta(1,k));

    xAnkle = xKnee + L2*cos(theta(2,k));
    yAnkle = yKnee + L2*sin(theta(2,k));

    xFoot = xAnkle + L3*cos(theta(3,k));
    yFoot = yAnkle + L3*sin(theta(3,k));

    % Link centers
    xUpper = xKnee/2;
    yUpper = yKnee/2;

    xCalf = xKnee + L2/2*cos(theta(2,k));
    yCalf = yKnee + L2/2*sin(theta(2,k));

    xFootCenter = xAnkle + L3/2*cos(theta(3,k));
    yFootCenter = yAnkle + L3/2*sin(theta(3,k));

    % Inertia about the base
    I(k) = ...
        mMKnee*(xKnee^2 + yKnee^2) + ...
        mMAnkle*(xAnkle^2 + yAnkle^2) + ...
        mLUpper*(xUpper^2 + yUpper^2 + L1^2/12) + ...
        mLCalf *(xCalf^2 + yCalf^2 + L2^2/12) + ...
        mLFoot *(xFootCenter^2 + yFootCenter^2 + L3^2/12);

    % Base, knee, ankle, and foot-end positions
    P = [0, xKnee, xAnkle, xFoot;
         0, yKnee, yAnkle, yFoot];

    clf
    hold on

    for i = 1:3
        plot(P(1,i:i+1), P(2,i:i+1), 'k', 'LineWidth', 2);
    end

    plot(P(1,2:3), P(2,2:3), 'bo', ...
         'MarkerFaceColor', [0.6 0.6 0.6]);

    axis equal
    xlim([-sum(L), sum(L)])
    ylim([-sum(L), sum(L)])
    drawnow
end

figure(2)
plot(t, I)
xlabel('Time (s)')
ylabel('Moment of inertia (kg m^2)')
grid on