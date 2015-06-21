# This script performs calculations on smartphone human activity data as required
# for the course project for Johns Hopkins/Coursera Getting and Cleaning data.
library(dplyr)
library(tidyr)

# Note uncompress 'UCI HAR Dataset.zip' into the working directory before running

# set up constants for file paths and names
kDataDir <- file.path( getwd(), "UCI HAR Dataset" )
kTrainDir <- file.path( kDataDir, "train" )
kTestDir <- file.path( kDataDir, "test" )
kFeatures <- "features.txt"
kActivities <- "activity_labels.txt"
kTrainDataset <- "X_train.txt"
kTestDataset <- "X_test.txt"
kTrainLabels <- "y_train.txt"
kTestLabels <- "y_test.txt"
kTrainSubjects <- "subject_train.txt"
kTestSubjects <- "subject_test.txt"

# Read in features table - provides the measured quantities in the train and test data
features <- read.table( file.path(kDataDir, kFeatures), 
                        stringsAsFactors = FALSE, 
                        col.names = c("number", "feature"))

# Create names for later use in labelling the final dataset.
# Personal preference is for camel case (aFormatThatSomePrefer), which arguably is also 
# closer to the format of the original data set.  
features$names <- features$feature

# Change first letter of 'function' names to upper case for later camel case
features$names <- gsub('\\-mean\\()', '.Mean()', features$names)
features$names <- gsub('\\-std\\()', '.Std()', features$names)
features$names <- gsub('\\-mad\\()', '.Mad()', features$names)
features$names <- gsub('\\-max\\()', '.Max()', features$names)
features$names <- gsub('\\-min\\()', '.Min()', features$names)
features$names <- gsub('\\-sma\\()', '.Sma()', features$names)
features$names <- gsub('\\-energy\\()', '.Energy()', features$names)
features$names <- gsub('\\-iqr\\()', '.Iqr()', features$names)
features$names <- gsub('\\-entropy\\()', '.Entropy()', features$names)
features$names <- gsub('\\-arCoeff\\()', '.ArCoeff()', features$names)
features$names <- gsub('\\-correlation\\()', '.Correlation()', features$names)
features$names <- gsub('\\-maxInds\\()', '.MaxInds()', features$names)
features$names <- gsub('\\-meanFreq\\()', '.MeanFreq()', features$names)
features$names <- gsub('\\-skewness\\()', '.Skewness()', features$names)
features$names <- gsub('\\-kertosis\\()', '.Kertosis()', features$names)
features$names <- gsub('\\-bandsEnergy\\()', '.BandsEnergy()', features$names)
# convert to valid column names and strip out periods
features$names <- make.names(features$names)
features$names <- gsub('\\.', '', features$names)

# Read in conversion from activity label to description
activities <- read.table( file.path(kDataDir, kActivities), 
                          stringsAsFactors = FALSE, 
                          col.names = c("label", "activity"))

# Read in individual train measurement data set, activities and subject and 
# combine into single table 
trainData <- read.table( file.path( kTrainDir, kTrainDataset),
                     col.names = features$names)    # Use modified features for column names
trainLabels <- read.table( file.path( kTrainDir, kTrainLabels),
                           col.names = "label")
trainSubjects <- read.table( file.path( kTrainDir, kTrainSubjects),
                             col.names = "subject")
train <- cbind( trainSubjects, trainLabels, trainData)

# Repeat loading for test data
testData <- read.table( file.path( kTestDir, kTestDataset),
                         col.names = features$names) 
testLabels <- read.table( file.path( kTestDir, kTestLabels),
                           col.names = "label")
testSubjects <- read.table( file.path( kTestDir, kTestSubjects),
                             col.names = "subject")
test <- cbind( testSubjects, testLabels, testData)

# Combine train and test data into a single data set
combined <- rbind( train, test)

# Select the measurements for which mean or standard deviation have been provided
# based on the feature name
idx = grepl( "-mean\\()|-std\\()", features$feature)
combinedMeanStd <- combined[ , c( TRUE, TRUE, idx) ]

# Add the descriptive activity field removing the label, and reorder columns
combinedMeanStd <- merge( combinedMeanStd, activities, by.x = "label", by.y = "label")
combinedMeanStd <- combinedMeanStd %>%
    select(-label) %>%
    select(subject, activity, tBodyAccMeanX:fBodyBodyGyroJerkMagStd)

# For each subject and activity, calculate an average for the mean and standard deviaton 
# of each measurement across multiple observations by gathering into a 'long tidy data' form
# and summarizing.
overallAverages <- gather( combinedMeanStd, measurement, value, -c(subject, activity)) %>%
    #!    select(subject, activity, measurement, value) %>%
    group_by( subject, activity, measurement ) %>%
    summarise( average = mean(value) )

# Convert to wide tidy data format to upload. Here will argue that the measurements 
# (eg tBodyAccMeanX, tGravityAccMeanZ) are different variables
overallAveragesWide = spread(overallAverages, measurement, average)
write.table(overallAveragesWide, "overall_averages_wide.txt", row.names=FALSE)

