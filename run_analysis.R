library(dplyr)

## Create a filename for local copy of file

projectfile <- "HAR_dataset.zip"

## If the projectfile does not already exist, download the data. 

if(!file.exists(projectfile)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, projectfile, method = "curl")
}

## Check if the zip file has already been unzipped 
## (ie folder "UCI HAR Dataset" exists) and if not, unzip it.

if(!file.exists("UCI HAR Dataset")) {
  unzip(projectfile)
}

## Create tables with named columns 

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("featureId","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityId")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityId")

## Merge the training and test datasets to create a single dataset

x_merged <- rbind(x_test, x_train)
y_merged <- rbind(y_test, y_train)
subject_merged <- rbind(subject_test, subject_train)
merged_dataset <- cbind(subject_merged, x_merged, y_merged)

## Extract only mean and standard deviation for each measurement

data_extract <- merged_dataset %>% select(subject, activityId, contains("mean"), contains("std"))

## Use descriptive activity names to name the activities

data_extract$activityId <- activities[data_extract$activityId, 2]

## Label the dataset with descriptive variable names

names(data_extract)[2] <- "Activity"
names(data_extract) <- gsub("Acc", "Accelerometer", names(data_extract))
names(data_extract) <- gsub("Gyro", "Gyroscope", names(data_extract))
names(data_extract) <- gsub("BodyBody", "Body", names(data_extract))
names(data_extract) <- gsub("Mag", "Magnitude", names(data_extract))
names(data_extract) <- gsub("^t", "Time", names(data_extract))
names(data_extract) <- gsub("^f", "Frequency", names(data_extract))
names(data_extract) <- gsub("tBody", "TimeBody", names(data_extract))
names(data_extract) <- gsub("-mean()", "Mean", names(data_extract), ignore.case = TRUE)
names(data_extract) <- gsub("-std()", "StdDev", names(data_extract), ignore.case = TRUE)
names(data_extract) <- gsub("-freq()", "Frequency", names(data_extract), ignore.case = TRUE)
names(data_extract) <- gsub("angle", "Angle", names(data_extract))
names(data_extract) <- gsub("gravity", "Gravity", names(data_extract))

## Create a tidy data set with the average of each variable for each activity 
## and each subject

summary_data <- data_extract %>%
  group_by(subject, Activity) %>%
  summarise_all(list(mean))
write.table(summary_data, "SummaryData.txt", row.name=FALSE)
