library("plyr")

# 1. Merges the training and the test sets to create one data set.

datadir <- "UCI HAR Dataset/"

x_train <- read.table(paste0(datadir, "train/X_train.txt"))
x_test <- read.table(paste0(datadir, "test/X_test.txt"))
y_train <- read.table(paste0(datadir, "train/y_train.txt"))
y_test <- read.table(paste0(datadir, "test/y_test.txt"))

subject_train <- read.table(paste0(datadir, "train/subject_train.txt"))
subject_test <- read.table(paste0(datadir, "test/subject_test.txt"))

x_bind <- rbind(x_train, x_test)
y_bind <- rbind(y_train, y_test)
subject_bind <- rbind(subject_train, subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table(paste0(datadir,"features.txt"))

# sub for measurement names with mean() or std()
features_sub <- grep("[-](mean|std)\\(\\)", features$V2)
# subset for these columns
x_bind <- x_bind[, features_sub]
# add column names
names(x_bind) <- features[features_sub, 2]

# 3. Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table(paste0(datadir,"activity_labels.txt"))
# update activity names
y_bind[, 1] <- activity_labels[y_bind[, 1], 2]
# update column name
names(y_bind) <- "activity"

# 4. Appropriately labels the data set with descriptive variable names.

names(subject_bind) <- "subject"
# combine all the data sources
data <- cbind(x_bind, y_bind, subject_bind)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# use ddply, splitting the data on subject and activity, finding the means
data_means <- ddply(data, .(subject, activity), function(x) colMeans(x[, -c(67,68)]))
write.table(data_means, "data_means.txt", row.name=FALSE)