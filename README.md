# Border Ownership in CNNs

This repository contains MATLAB code to reproduce the experiments and analyses
reported in:

"Approaching human visual perception through AI-based representation of
figure-ground segregation"

## Contents
- `code/makeStim.m/`: stimulus generation
- `code/makeStim256.m/`: stimulus generation for 256 groups of fragmentation
- `code/regression_model.m` and `code/accuracy.m`: performance and statistical analyses
- `code/saliency_mapping.m/`: Grad-CAM analysis
- `figures/`: figures included in the manuscript
- `code/function/`: the MATLAB function used in the script

## Reproducing the Results
1. Generate stimuli:
   - Run `makeStim.m` and `makeStim256.m` to obtain the training set and testing set (adjust parameter to get desired output)
2. Train networks:
   - Run `BOnet.m` to train the desired network
3. Evaluate fragmentation and generalization:
   - Run `regression_model.m` to obtain the result for the coefficient and `accuracy.m` to obtain accuracy and significance results from generalization and fragmentation
4. Generate Grad-CAM visualizations:
   - Run `saliency_mapping.m` to obtain the visualization of Grad-CAM for the network

## Data Availability
All datasets used in this study are procedurally generated.
Raw training data are not stored but can be regenerated using the provided code.

## Requirements
- MATLAB R2021a or later
- Deep Learning Toolbox
