# Getting and Cleaning Data Course Project
#
## You should create one R script called run_analysis.R that does the following.
## 1 - Merges the training and the test sets to create one data set.
## 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
## 3 - Uses descriptive activity names to name the activities in the data set
## 4 - Appropriately labels the data set with descriptive variable names.
## 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Initialize required libraries

require(data.table)
require(reshape2)


# Load the activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Load the features to name the table columns
feature_labels <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Create a dataset based on test data

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")

names(X_test) = feature_labels

## Extract only the measurements on the mean and standard deviation for each measurement.
X_test = X_test[,grepl("mean|std", feature_labels)]

## Assign the activity labels and name all colums descriptively (no spaces, dots, underscores, all lowercase)
Y_test[,2] = activity_labels[Y_test[,1]]
names(Y_test) = c("activityid", "activitylabel")
names(subject_test) = "subject"

## Create one test dataset
test_data <- cbind(as.data.table(subject_test), Y_test, X_test)

# Create a dataset based on train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")

names(X_train) = feature_labels

## Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,grepl("mean|std", feature_labels)]

## Assign the activity labels and name all colums descriptively (no spaces, dots, underscores, all lowercase)
Y_train[,2] = activity_labels[Y_train[,1]]
names(Y_train) = c("activityid", "activitylabel")
names(subject_train) = "subject"

## Create one train dataset
train_data <- cbind(as.data.table(subject_train), Y_train, X_train)


# Create one single dataset called "data"
data = rbind(test_data, train_data)

id_labels   = c("subject", "activityid", "activitylabel")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)


# Create a tidy dataset with the averages for each variable, subject and activity
tidy_data   = dcast(melt_data, subject + activitylabel ~ variable, mean)

write.csv(tidy_data, file = "./tidy_data.csv")
