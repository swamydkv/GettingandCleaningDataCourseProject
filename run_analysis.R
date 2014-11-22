#Step 1: "Merges the training and the test sets to create one data set."
#
# read subject training data
subject_training = read.table("./GettingandCleaningDataCourseProject/UCI HAR Dataset/train/subject_train.txt", col.names=c("subject_id"))
# assign row number as the values of ID column
subject_training$ID <- as.numeric(rownames(subject_training))

# read training data
X_training = read.table("./GettingandCleaningDataCourseProject/UCI HAR Dataset/train/X_train.txt")
# assign row number as the values of ID column
X_training$ID <- as.numeric(rownames(X_training))

# read activity training data
Y_training = read.table("./GettingandCleaningDataCourseProject/UCI HAR Dataset/train/y_train.txt", col.names=c("activity_id"))
# assign row number as the values of ID column
Y_training$ID <- as.numeric(rownames(Y_training))

# merge subject_training and Y_training to training
training <- merge(subject_training, Y_training, all=TRUE)
# merge training and X_training
training <- merge(training, X_training, all=TRUE)


# read subject training data
subject_test = read.table("./GettingandCleaningDataCourseProject/UCI HAR Dataset/test/subject_test.txt", col.names=c("subject_id"))
# assign row number as the values of ID column
subject_test$ID <- as.numeric(rownames(subject_test))

# read testing data
X_test = read.table("./GettingandCleaningDataCourseProject/UCI HAR Dataset/test/X_test.txt")
# assign row number as the values of ID column
X_test$ID <- as.numeric(rownames(X_test))

# read activity testing data
Y_test = read.table("./GettingandCleaningDataCourseProject/UCI HAR Dataset/test/Y_test.txt", col.names=c("activity_id"))
# assign row number as the values of ID column
Y_test$ID <- as.numeric(rownames(Y_test))

# merge subject_test and Y_test to training
test <- merge(subject_test, Y_test, all=TRUE)
# merge test and X_test
test <- merge(test, X_test, all=TRUE) 


#combine training and test
data1 <- rbind(training, test)


#Step 2: "Extracts only the measurements on the mean and standard deviation for each measurement."
#
features = read.table("./GettingandCleaningDataCourseProject/UCI HAR Dataset/features.txt", col.names=c("feature_id", "feature_label"),)

#Extracts only the measurements on the mean and standard deviation for each measurement.
selected_features <- features[grepl("mean\\(\\)", features$feature_label) | grepl("std\\(\\)", features$feature_label), ]
data2 <- data1[, c(c(1, 2, 3), selected_features$feature_id + 3) ]


#Step 3: "Uses descriptive activity names to name the activities in the data set."
#
activity_labels = read.table("./GettingandCleaningDataCourseProject/UCI HAR Dataset/activity_labels.txt", col.names=c("activity_id", "activity_label"),)
data3 = merge(data2, activity_labels)


#Step 4: "Appropriately labels the data set with descriptive activity names."
#
selected_features$feature_label = gsub("\\(\\)", "", selected_features$feature_label)
selected_features$feature_label = gsub("-", ".", selected_features$feature_label)
for (i in 1:length(selected_features$feature_label)) {
    colnames(data3)[i + 3] <- selected_features$feature_label[i]
}

data4 = data3


#Step 5: "Creates a second, independent tidy data set with the average of each variable for each activity and each subject."
#
drops <- c("ID","activity_label")
data5 <- data4[,!(names(data4) %in% drops)]
aggdata <- aggregate(data5, by=list(subject = data5$subject_id, activity = data5$activity_id), FUN=mean, na.rm=TRUE)
drops <- c("subject","activity")
aggdata <- aggdata[,!(names(aggdata) %in% drops)]
aggdata = merge(aggdata, activity_labels)
write.csv(file="./GettingandCleaningDataCourseProject/submit.csv", x=aggdata)
data4 = data3
