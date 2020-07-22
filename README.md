# Boeing737_PowerSystem_in_Modelica
This repository contains a Boeing 737 Power System Model, as implemented in Modelica. The aircraft's distribution system has been fully implemented utilizing Modelica's object orientation, allowing easy replaceability of componenents. The system, that can be noted below, has all its components as replaceable (sunken boxes) that can be easily swapped with existing components in the library or ones that can be implemented using the existing base classes.

![alt text](https://github.com/ALSETLab/Boeing737_PowerSystem_in_Modelica/blob/master/Flight_Simulation_Example/system.jpg)

More details on this model can be found on the accompaning conference paper. If you use these models, please cite as follows:
> S. Konstantinopoulos, H. Nademi and L. Vanfretti, “Dynamic System Modeling and Stability Assessment of Aircraft Distribution Power Systems using Modelica and the FMI,” AIAA/IEEE Electric Aircraft Technologies Symposium (EATS), 26–28 August 2020, New Orleans, LA.

The author's pre-print copy of this paper can be found under the `./Doc/` directory in this repository:


## How to simulate the aircraft's power system?
In your modelica tool of choice, e.g. Dymola, follow the steps below:

- File/Open `./AircraftPowerSystem.mo`
- Under the main package, navigate to `AircraftPowerSystem.Systems.Template.Configurations.DistributionSystem_DC1_Simple`
- Switch to the simulation tab and `Simulate` (or alternatively press F10).

The flight time is simulated in 60 seconds and a sample of the loads' consumptions and the generator's output can be noted below.

![alt text](https://github.com/ALSETLab/Boeing737_PowerSystem_in_Modelica/blob/master/Flight_Simulation_Example/flight.jpg)


## Using Templates

As one can notice, only one version of each load is included. Many more loads can be included with our template format. One can choose to simulate many ball screw actuators simultaneously with various profiles. This can be easily achieved by just placing additional `AircraftPowerSystem.Components.Load_Temp.DC_Load` blocks in the main template, and clicking right and choosing to replace them with the Permanent Magnet Synchronous Motor (PMSM) load.

![alt text](https://github.com/ALSETLab/Boeing737_PowerSystem_in_Modelica/blob/master/Flight_Simulation_Example/rep.png)

## Development and contribution
The library is developed by [Stavros Konstantinopoulos](https://github.com/StavrosKon) and [Luigi Vanfretti](https://github.com/lvanfretti).

Contributions are welcome via pull requests.

## License - No Warranty
This Modelica software package is free software and the use is completely at your own risk; it can be redistributed and/or modified under the terms of the GNU Public License version 3.

Copyright (C) 2020, Stavros Konstantinopoulos and Luigi Vanfretti.
