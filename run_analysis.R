
run_analysis <- function() {
  # First, unzip the dataset
  unzip("HarData.zip", exdir = "HarData")
  
  # Step 1: Load and merge the training and test datasets
  
  # Read feature names and activity labels
  features <- read.table("HarData/UCI HAR Dataset/features.txt", col.names = c("index", "feature"))
  activities <- read.table("HarData/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
  
  # Read training data
  x_train <- read.table("HarData/UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("HarData/UCI HAR Dataset/train/y_train.txt", col.names = "activity")
  subject_train <- read.table("HarData/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
  
  # Read test data
  x_test <- read.table("HarData/UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("HarData/UCI HAR Dataset/test/y_test.txt", col.names = "activity")
  subject_test <- read.table("HarData/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
  
  # Merge training and test data
  x_data <- rbind(x_train, x_test)
  y_data <- rbind(y_train, y_test)
  subject_data <- rbind(subject_train, subject_test)
  
  # Assign column names to x_data
  colnames(x_data) <- features$feature
  
  # Merge all data
  merged_data <- cbind(subject_data, y_data, x_data)
  
  # Step 2: Extract only the measurements on the mean and standard deviation
  selected_columns <- grepl("mean\\(\\)|std\\(\\)", features$feature)
  filtered_data <- merged_data[, c(TRUE, TRUE, selected_columns)]
  
  # Step 3: Use descriptive activity names
  tidy_data <- merge(filtered_data, activities, by.x = "activity", by.y = "code", all.x = TRUE)
  tidy_data$activity <- tidy_data$activity.y
  tidy_data <- select(tidy_data, -activity.y)
  
  # Step 4: Label the dataset with descriptive variable names
  names(tidy_data) <- gsub("-mean\\(", "Mean", names(tidy_data))
  names(tidy_data) <- gsub("-std\\(", "Std", names(tidy_data))
  names(tidy_data) <- gsub("[()]", "", names(tidy_data))
  names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
  names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
  names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
  names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
  names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
  names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
  
  # Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject
  final_tidy_data <- tidy_data %>%
    group_by(subject, activity) %>%
    summarise_all(mean)
  
  # Save the final tidy dataset to a file
  write.table(final_tidy_data, "tidy_data.txt", row.name = FALSE, sep = ",", quote = FALSE)
  
  return(final_tidy_data)
}

final_tidy_data <- run_analysis()

