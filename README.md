# binocular_rivalry

## Description
This project was created as part of a CentraleSupélec course, entitled "Dynamical systems & Neuroscience". The course was taught by Professor Antoine Chaillet.
The aim of this project was to understand more about the phenomenon of binocular rivalry. This phenomenon takes place when dissimilar images are presented simultaneously to each eye.

This project was encoded using Matlab and Simulink.

## Structure of the project
- simulation.xls : provides a Simulink model of H.R.Wilson simple populayion model for binocular rivalry.
- derivee.m : computes the derivatives of the functions defined in H.R.Wilson's model :
E_L, the neuronal activity driven by L(t)
E_R, the neuronal activity driven by R(t)
H_L and H_R, the slow hyperpolarizing currents
with L(t) the intensity of the stimulus on the left eye
and R(t) the intensity of the stimulus on the red eye.
- bifurcation_diagram : enables to plot the time evolution of the neuronal activities and the bifurcation diagram, the steady-state duration of perception of the left and right stimuli, and to compute the alternation period.
