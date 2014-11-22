# Code Book for Getting and Cleaning Data Course Project
This code book describes the variables, the data, and any transformations or work that you performed to clean up the data
* Step 1: "Merges the training and the test sets to create one data set."
* Step 2: "Extracts only the measurements on the mean and standard deviation for each measurement."
* Step 3: "Uses descriptive activity names to name the activities in the data set."
* Step 4: "Appropriately labels the data set with descriptive activity names." 
* Step 5: "Creates a second, independent tidy data set with the average of each variable for each activity and each subject."


# Variables

* `X_training`, `Y_training`, `X_test`, `Y_test`, `subject_training` and `subject_test` contain the data from the downloaded files.
* `features` and `activity_labels` contain data from `features.txt` and `activity_labels.txt`
* `training`, `test`, `data1`, `data2`, `data3` and `data4` merge the previous datasets to further analysis.
* Finally, `submit.txt` contains the relevant averages.
