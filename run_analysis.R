library(reshape2)

# Load activity labels and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation of each measurement
features_needed <- grep(".*mean.*|.*std.*", features[,2])
features_needed.names <- features[features_needed,2]
features_needed.names = gsub('-mean', 'Mean', features_needed.names)
features_needed.names = gsub('-std', 'Std', features_needed.names)
features_needed.names <- gsub('[-()]', '', features_needed.names)


# Load the train datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_needed]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

# Load the test datasets
test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_needed]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge training abd testing datasets
mergedData <- rbind(train, test)
#Add labels to the merged dataset
colnames(mergedData) <- c("subject", "activity", features_needed.names)

# Transform activities & subjects into factors
mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mergedData$subject <- as.factor(mergedData$subject)

mergedData.melted <- melt(mergedData, id = c("subject", "activity"))
mergedData.mean <- dcast(mergedData.melted, subject + activity ~ variable, mean)

#Write the merged tidy data to a file
write.table(mergedData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)

