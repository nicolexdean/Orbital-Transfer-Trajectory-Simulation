%% Hohmann Transfer Orbit Simulation
% Calculates and visualizes a Hohmann transfer between two circular,
% coplanar Earth orbits.
%
% Assumptions:
% - Two-body orbital mechanics
% - Circular initial and final orbits
% - Coplanar orbits
% - Impulsive (instantaneous) burns
% - Earth is modeled as a spherical central body
% - Atmospheric drag and other perturbations are neglected

clear;
clc;
close all;

%% Constants and Inputs

mu = 398600.4418;      % Earth's gravitational parameter [km^3/s^2]
R_E = 6378.137;        % Earth's mean equatorial radius [km]

% Example case: 300 km LEO to GEO
h1 = 300;              % Initial altitude above Earth [km]
h2 = 35786;            % Final altitude above Earth [km]

% Convert altitude to orbital radius
r1 = R_E + h1;
r2 = R_E + h2;


%% Circular Orbit Velocities

% Velocity of spacecraft in each circular orbit
v1 = sqrt(mu/r1);
v2 = sqrt(mu/r2);


%% Hohmann Transfer Orbit

% Semi-major axis of transfer ellipse
a_transfer = (r1 + r2)/2;

% Eccentricity of transfer ellipse
e_transfer = abs(r2 - r1)/(r1 + r2);

% Velocity on transfer orbit at first burn
v_transfer1 = sqrt(mu*(2/r1 - 1/a_transfer));

% Velocity on transfer orbit at second burn
v_transfer2 = sqrt(mu*(2/r2 - 1/a_transfer));


%% Delta-V Calculations

% First burn: circular orbit to transfer ellipse
deltaV1 = v_transfer1 - v1;

% Second burn: transfer ellipse to final circular orbit
deltaV2 = v2 - v_transfer2;

% Total maneuver delta-v
deltaV_total = abs(deltaV1) + abs(deltaV2);


%% Transfer Time

% A Hohmann transfer takes half of the transfer ellipse's orbital period
transferTime = pi*sqrt(a_transfer^3/mu);

transferTime_min = transferTime/60;
transferTime_hr = transferTime/3600;


%% Display Results

fprintf('\nHOHMANN TRANSFER RESULTS\n');
fprintf('====================================\n');

fprintf('Initial altitude:             %.2f km\n', h1);
fprintf('Final altitude:               %.2f km\n', h2);

fprintf('Initial orbit radius:         %.2f km\n', r1);
fprintf('Final orbit radius:           %.2f km\n', r2);

fprintf('\nTransfer semi-major axis:     %.2f km\n', a_transfer);
fprintf('Transfer eccentricity:        %.4f\n', e_transfer);

fprintf('\nInitial circular velocity:    %.4f km/s\n', v1);
fprintf('Final circular velocity:      %.4f km/s\n', v2);

fprintf('\nDelta-V Burn 1:               %.4f km/s\n', deltaV1);
fprintf('Delta-V Burn 2:               %.4f km/s\n', deltaV2);
fprintf('Total Delta-V:                %.4f km/s\n', deltaV_total);

fprintf('\nTransfer time:                %.2f min\n', transferTime_min);
fprintf('Transfer time:                %.2f hr\n', transferTime_hr);


%% Generate Initial and Final Circular Orbits

theta = linspace(0, 2*pi, 500);

% Initial orbit position
x1 = r1*cos(theta);
y1 = r1*sin(theta);

% Final orbit position
x2 = r2*cos(theta);
y2 = r2*sin(theta);


%% Generate Transfer Orbit

% Hohmann transfer travels through half of the transfer ellipse
theta_transfer = linspace(0, pi, 300);

% Semi-latus rectum
p = a_transfer*(1 - e_transfer^2);

% Radius along transfer ellipse
r_transfer = p ./ (1 + e_transfer*cos(theta_transfer));

% Convert from polar to Cartesian coordinates
x_transfer = r_transfer .* cos(theta_transfer);
y_transfer = r_transfer .* sin(theta_transfer);


%% Generate Earth

theta_E = linspace(0, 2*pi, 300);

x_E = R_E*cos(theta_E);
y_E = R_E*sin(theta_E);


%% Plot Hohmann Transfer

figure;

% Initial circular orbit
plot(x1, y1, 'LineWidth', 1.5);
hold on;

% Final circular orbit
plot(x2, y2, 'LineWidth', 1.5);

% Transfer trajectory
plot(x_transfer, y_transfer, 'LineWidth', 2);

% Earth
fill(x_E, y_E, [0.7 0.7 0.7]);

% Departure and arrival locations
plot(r1, 0, 'ko', 'MarkerFaceColor', 'm');
plot(-r2, 0, 'ko', 'MarkerFaceColor', 'm');

% Plot formatting
axis equal;
grid on;

xlabel('x Position [km]');
ylabel('y Position [km]');

title(sprintf('Hohmann Transfer: %.0f km LEO to %.0f km GEO', ...
    h1, h2));

legend('Initial Circular Orbit','Final Circular Orbit','Transfer Orbit','Earth','Departure Point','Arrival Point','Location', 'best');

hold off;


%% Validation

% Approximate reference values for a 300 km LEO to GEO transfer.
% These values provide a basic check that the calculated results are
% physically reasonable.

expected_dV1 = 2.43;       % [km/s]
expected_dV2 = 1.47;       % [km/s]
expected_time = 5.28;      % [hr]

fprintf('\nVALIDATION CHECK\n');
fprintf('====================================\n');

fprintf('Calculated Burn 1: %.3f km/s | Expected: ~%.2f km/s\n',abs(deltaV1), expected_dV1);

fprintf('Calculated Burn 2: %.3f km/s | Expected: ~%.2f km/s\n', abs(deltaV2), expected_dV2);

fprintf('Calculated Time:   %.3f hr   | Expected: ~%.2f hr\n',transferTime_hr, expected_time);

fprintf('\nSimulation complete.\n');