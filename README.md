# Getting and Cleaning Data Course Project

Repository for the Week 4 project from Coursera's Getting and Cleaning Data Course. It includes the instructions for running the analysis on the Human Activity Recognition dataset.

## Dataset

[Human Activity Recognition using Smartphones](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)

Reyes-Ortiz,Jorge, Anguita,Davide, Ghio,Alessandro, Oneto,Luca, and Parra,Xavier. (2012). Human Activity Recognition Using Smartphones. UCI Machine Learning Repository. <https://doi.org/10.24432/C54S4K.>

## Files

-   `codebook.md` is the codebook describing the variables, the data and the transformations performed to tidy the data

-   `run_analysis.R` downloads and processes the data, and performs the five steps of the analysis as required by the project:

    -   Merges the training and the test sets to create one data set.

    -   Extracts only the measurements on the mean and standard deviation for each measurement.

    -   Uses descriptive activity names to name the activities in the data set

    -   Appropriately labels the data set with descriptive variable names.

    -   From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

-   `SummaryData.txt` is the exported final output from the above steps.
