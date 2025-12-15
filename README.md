# Border Ownership in CNNs

This repository contains MATLAB code to reproduce the experiments and analyses
reported in:

"Approaching human visual perception through AI-based representation of
figure-ground segregation"

## Contents
- `code/stimuli/`: stimulus generation scripts
- `code/training/`: CNN training scripts
- `code/evaluation/`: performance and statistical analyses
- `code/visualization/`: Grad-CAM analysis
- `figures/`: figures included in the manuscript

## Reproducing the Results
1. Generate stimuli:
   - Run `generate_rectangles.m`
2. Train networks:
   - Run scripts in `code/training/`
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
