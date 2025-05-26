# Bone Cancer Biopsy Navigation

This repository contains Assignment 3 for CISC 330: Computer Integrated Surgery. The project focuses on developing a navigation system to assist in bone cancer biopsy procedures, emphasizing precise instrument calibration and spatial transformations.

## Project Overview

The objective of this assignment is to implement and test algorithms that facilitate accurate navigation during bone cancer biopsies. The system ensures precise alignment and positioning of surgical instruments relative to patient anatomy.

## Repository Structure

- `main.m`: The main script that orchestrates the execution of various functions and algorithms.
- `AxisCalibrationtesting.m` & `Axiscalibration.m`: Scripts related to the calibration of rotational axes.
- `TipCalibrationtesting.m` & `Tipcalibration.m`: Scripts for calibrating the tip of the surgical instrument.
- `Frame_Transformation_to_Home.m`: Handles transformations to the home coordinate frame.
- `Generate_Orthogonal_Frame.m`: Generates an orthogonal frame based on input data.
- `Intersect_Line_and_Plane.m`: Computes the intersection point between a line and a plane.
- `Rotation_about_Frame_Axis.m`: Performs rotation operations about a specified frame axis.
- `sphereFit.m` & `CircFit3D.m`: Functions for fitting geometric shapes (sphere and circle) to 3D data points.

## Getting Started

### Prerequisites

- MATLAB (version R2020a or later recommended)

### Running the Project

1. Clone the repository:
   ```bash
   git clone https://github.com/adenjwong/Bone-Cancer-Biopsy-Navigation.git
   
2. Navigate to the project directory:
   ```bash
   cd Bone-Cancer-Biopsy-Navigation
   
3. Open MATLAB and add the project directory to the MATLAB path.

4. Run the main script.

## Usage

The main.m script sequentially executes the calibration and transformation functions to simulate the navigation process during a bone cancer biopsy. Ensure that all dependent scripts are in the same directory or appropriately referenced.
