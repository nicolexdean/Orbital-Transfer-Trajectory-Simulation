# Hohmann Transfer Orbit Simulation

MATLAB simulation of a Hohmann orbital transfer between circular,
coplanar Earth orbits.

## Results

For a 300 km LEO-to-GEO transfer:

- Total Delta-V: 3.89 km/s
- Transfer Time: 5.28 hours
- Initial Altitude: 300 km
- Final Altitude: 35,786 km

![Hohmann Transfer Simulation](images/hohmann_transfer_plot.png)

## Features

- Calculates transfer orbit semi-major axis and eccentricity
- Calculates delta-v required for both maneuver burns
- Calculates total maneuver delta-v
- Calculates Hohmann transfer time
- Generates a 2D visualization of the orbital trajectory
- Validates results against theoretical orbital mechanics predictions

## Engineering Model

The simulation uses two-body orbital mechanics and the vis-viva equation.

### Assumptions

- Circular initial and final orbits
- Coplanar orbits
- Impulsive burns
- Spherical Earth
- Atmospheric drag neglected
- Third-body gravitational effects neglected

## Validation

The model was validated using a 300 km LEO-to-GEO transfer.

Calculated results:

| Parameter | Result |
|---|---:|
| Burn 1 Delta-V | 2.43 km/s |
| Burn 2 Delta-V | 1.47 km/s |
| Total Delta-V | 3.89 km/s |
| Transfer Time | 5.28 hr |

These values agree with theoretical predictions for an ideal
Hohmann transfer.

## Running the Simulation

1. Download or clone the repository.
2. Open `OrbitalTransferSimulation.m` in MATLAB.
3. Set the desired initial and final orbit altitudes.
4. Run the script.

The calculated maneuver parameters are displayed in the MATLAB
Command Window and the orbital trajectory is plotted automatically.

## Limitations

This simulation represents an ideal Hohmann transfer. Real spacecraft
trajectories may require consideration of finite burn durations,
inclination changes, atmospheric drag, launch conditions, navigation
errors, and additional gravitational perturbations.