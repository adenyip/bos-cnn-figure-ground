# Border Ownership in CNNs

This repository contains MATLAB code to reproduce the experiments and analyses
reported in:

"Approaching human visual perception through AI-based representation of
figure-ground segregation"

## Contents
- `code/makeStim/`: stimulus generation
- `code/makeStim 256/`: stimulus generation for 256 groups of fragmentation
- `code/evaluation/`: performance and statistical analyses
- `code/visualization/`: Grad-CAM analysis
- `figures/`: figures included in the manuscript

## Reproducing the Results
1. Generate stimuli:
   - Run `makeStim.m` to obtain the training set and testing set (adjust parameter)
2. Train networks:
   - Run `BOnet.m` to train the desired network
3. Evaluate fragmentation and generalization:
   - Run scripts in `code/evaluation/`
4. Generate Grad-CAM visualizations:
   - Run `gradcam_analysis.m`

## Data Availability
All datasets used in this study are procedurally generated.
Raw training data are not stored but can be regenerated using the provided code.

## Requirements
- MATLAB R2021a or later
- Deep Learning Toolbox
