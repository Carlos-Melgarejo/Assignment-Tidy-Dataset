# Assignment-Tidy-Dataset
This repository is a submission for Getting and Cleaning Data course project. 

**Dataset description:**
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

**Dataset:**
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

*Files*:

**CodeBook.md** code book describing the variables, the data, and any transformations or work that I performed to clean up the data

**run_analysis.R**: Performs the data preparation followed by the steps described below:
  1- Merges the training and the test sets to create one data set.
  2- Extracts only the measurements on the mean and standard deviation for each measurement.
  3- Uses descriptive activity names to name the activities in the data set
  4- Appropriately labels the data set with descriptive variable names.
  5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and   each subject.

**Tidy_Data.txt**: Exported data after applying the analysis described above 
