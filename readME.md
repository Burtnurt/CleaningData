# Human activity recognition data analysis

## Overview
This script performs data cleaning and analysis on the "Human Activity Recognition" dataset. The dataset contains data collected from smartphones during various physical activities. The goal of this script is to:

1. Load and merge the training and test datasets.
2. Extract measurements on the mean and standard deviation for each feature.
3. Use descriptive activity names for the activities.
4. Label the dataset with descriptive variable names.
5. Create a second tidy dataset with the average of each variable for each activity and each subject.

## Requirements
To install the necessary packages, you can run:
```r
install.packages("dplyr")