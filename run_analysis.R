library(dplyr)

filename <- "tidy_dataset.zip"

# Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Data frame features
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 1_Merging the training and the test sets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
MergedData <- cbind(Subject, Y, X)

# 2_Extracting only measurements on the mean and standard deviation
ProperData <- MergedData %>% select(subject, code, contains("mean"), contains("std"))

# 3_Using descriptive activity names to name the activities
ProperData$code <- activities[ProperData$code, 2]

# 4_Labeling data set with descriptive variable names
names(ProperData)[2] = "activity"
names(ProperData)<-gsub("Acc", "Accelerometer", names(ProperData))
names(ProperData)<-gsub("Gyro", "Gyroscope", names(ProperData))
names(ProperData)<-gsub("BodyBody", "Body", names(ProperData))
names(ProperData)<-gsub("Mag", "Magnitude", names(ProperData))
names(ProperData)<-gsub("^t", "Time", names(ProperData))
names(ProperData)<-gsub("^f", "Frequency", names(ProperData))
names(ProperData)<-gsub("tBody", "TimeBody", names(ProperData))
names(ProperData)<-gsub("-mean()", "Mean", names(ProperData), ignore.case = TRUE)
names(ProperData)<-gsub("-std()", "STD", names(ProperData), ignore.case = TRUE)
names(ProperData)<-gsub("-freq()", "Frequency", names(ProperData), ignore.case = TRUE)
names(ProperData)<-gsub("angle", "Angle", names(ProperData))
names(ProperData)<-gsub("gravity", "Gravity", names(ProperData))

Tidy_Data <- ProperData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Tidy_Data, "Tidy_Data.txt", row.name = FALSE)