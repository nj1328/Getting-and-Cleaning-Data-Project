The run_analysis.R script pre-processes the data, then performs the various steps required to perform the desired analysis.

Requires `dplyr` package.

## Data pre-processing

The data, in zip file format, is downloaded and then extracted to the working directory in the folder `UCI HAR Dataset`. It is then loaded into various tables.

`features` \<- features.txt (561 observations, 2 variables)\
*features are from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ*

`activities` \<- `activities.txt` (6 observations, 2 variables)\
*activities performed while using a smartphone*

`subject_test` \<- `subject_test.txt` (2947 observations, 1 variable)\
*test data of test subjects*

`x_test` \<- `x_test.txt` (2947 observations, 561 variables)\
*recorded features test data*

`y_test` \<- `y_test.txt` (2947 observations, 1 variable)\
*test data activity code labels*

`subject_train` \<- `subject_train.txt` (7352 observations, 1 variable)\
*training data of test subjects*

`x_train` \<- `x_train.txt` (7352 observations, 561 variables)\
*recorded features training data*

`y_train` \<- `y_train.txt` (7352 observations, 1 variable)\
*training data activity code labels*

## 1. Creating a single dataset by merging the test and training datasets

-   `x_merged` (10299 observation, 561 variables) - created from `x_test` and `x_train` by **rbind()**

-   `y_merged` (10299 observations, 1 variable) - created from `y_test` and `y_train` by **rbind()**

-   `subject_merged` (10299 observations, 1 variable) - created from `subject_test` and `subject_train` by **rbind()**

-   `merged_dataset` (10299 observations, 563 variables) - created from `subject_merged`, `x_merged` and `y_merged` by **cbind()**

## 2. Extract only mean and standard deviation for each measurement

`data_extract` (10299 observations, 88 variables) is created as a subset of `merged_dataset` with only the columns `subject`, `activityID` and for each measurement, mean and standard deviation.

## 3. Use descriptive activity names to name the activities in the dataset

Replace `activityId` in the dataset by the name of the activity sourced from the second column of the `activities` table.

## 4. Label the dataset with descriptive variable names

-   activityID renamed Activity

-   Acc replaced by Accelerometer

-   Gyro replaced by Gyroscope

-   BodyBody replaced by Body

-   Mag replaced by Magnitude

-   If t is in the first column, replaced by Time

-   If f is in the first column, replaced by Frequency

-   tBody replaced by TimeBody (there are a few occurences of this that are not in the first characters of the name)

-   -mean() replaced by Mean

-   -std() replaced by StdDev

-   -freq() replaced by Frequency

-   angle replaced by Angle

-   gravity replaced by Gravity

The resultant `data_extract` dataset is now tidy.

## 5. Create a second, independent tidy dataset with the average of each variable for each activity and each subject

The tidy dataset `summary_data` (180 observations, 88 variables) is created by summarising `data_extract`, with averages determined grouped by `subject` and `Activity`.

It is then exported to a text file `SummaryData.txt` in the working directory.
