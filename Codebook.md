# Code book for HAR data

## Data Source
The data comes from the "Human Activity Recognition Using Smartphones" dataset

## Variables
### Main Variables:
- **subject**: Identifier for the subject who performed the activity (1-30).
- **activity**: The type of activity being performed, with values:
  - Walking
  - Walking Upstairs
  - Walking Downstairs
  - Sitting
  - Standing
  - Laying
- **Feature Variables**: These are measurements of the accelerometer and gyroscope data. These variables are standardized and include:
  - **Time domain features** (e.g., `tBodyAcc-mean-X`, `tBodyGyro-std-Z`)
  - **Frequency domain features** (e.g., `fBodyAcc-mean-X`, `fBodyGyro-std-Y`)
  
  ### Data Transformation:
- The dataset includes both the mean and standard deviation for each measurement. The variables are labeled using descriptive names, e.g., `TimeBodyAccelerometerMean-X`.
- The final tidy dataset includes the average of each measurement for each subject and activity.