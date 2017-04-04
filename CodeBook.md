# run_analysis.R
Consists of 5 steps outlined

1. Merges the training and the test sets to create one data set.
    + Using rbind() functions to merge test and train sets with conmmon columns.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
    + Only the columns of interest were selected by searching the column names with regex.
3. Uses descriptive activity names to name the activities in the data set
    + Corrected the activity names using features.txt.
4. Appropriately labels the data set with descriptive variable names.
    + Cleaned up messy variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    + And lastly used ddplyr from the plyr library to apply colMeans() to each subject and activity combination and output this to data_means.txt.

# Variables
* x_train, y_train, x_test, y_test, subject_train and subject_test are the tables from the downloaded files.
* x_bind, y_bind and subject_bind merge the datasets above.
* features contains the correct names for the x_data dataset.
* activity_labels similar to features.
* data merges x_bind, y_bind and subject_bind into one dataset.
* data_means contains the averages from ddply() which is outputted to data_means.txt
