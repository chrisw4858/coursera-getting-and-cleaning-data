---
title: "Getting and Cleaning Data Project Codebook"
author: "ChrisW4858"
date: "June 2015"
output:
  html_document:
    keep_md: yes
---

## Project Description
The goal of the project is to produce a tidy data set providing a summary of smart phone human activity data.

##Study design and collection of the raw data
The study is based on recorded motion data of 30 subjects performing a variety of activities such as walking, sitting and standing while wearing a Samsung Galaxy S II smartphone.  Gyroscope and accelerometer readings for angular velocity and linear acceleration in 3 dimensions was recorded.

Preprocessing has already been performed in the original dataset to apply noise filters and fourier transform and additional variables derived.  The original dataset also provides statistical summary type values (such as mean, standard deviation, min, max) to form a data set of 561 variables per observation.

A full description of the data is provided at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The full data set is available from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.


##Data Processing

### Features and Activities
Accelerometer and gyrscope measurements are referred to as features.  The names of the features (features.txt) are loaded from features.txt, and transformed to provide descriptive names that are valid R column names. Descriptive terms for the various activities are loaded from activity_labels.txt

###Train and Test Data
The provided data set has been split into separate training and test dataset portions. Each of these are formatting similarly.  These data sets provide multipe observations for each subject/activity combination.

The training accelerometer and gyrscope data (X_train.txt), subject id (subject_train.txt) and activity id (y_train.txt) are loaded and combined into a single data frame.  Descriptive names for the motion data are applied based on the previously processed features.

The test data set is processed similarly. 

###Combined Data Set
The train and test data sets are combined into a single data set.  Only variables for mean and standard deviation were retained, other summaries such as max, min... were discarded. 

(Note: the interpretion of features_info.txt here is that "meanFreq()" is a different variable from "mean()" or"std()" and hence was not included in the analysis.)

The activity id (label) is replaced with a descriptive term.

###Overall Averages
The multiple observations for each subject/activity were averaged to provide a single average.  These are written to file (overall_averages_wide.txt) in a wide tidy data format. 

###Notes on the original (raw) data 
Some additional notes (if avaialble, otherwise you can leave this section out).

##Creating the tidy datafile

###Guide to create the tidy data file
Description on how to create the tidy data file (1. download the data, ...)/

###Cleaning of the data
Short, high-level description of what the cleaning script does. [link to the readme document that describes the code in greater detail]()

##Description of the variables in the overall_averages_wide.txt file
The final result consists of 180 observations of 68 variables. This consists of averages for 66 features for each of 30 subjects performing 6 different activities.
General description of the file including:
 - Dimensions of the dataset
 - Summary of the data
 - Variables present in the dataset

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

###Subject
The ID of the subject performing the actitity in the form of an integer in the range 1-30.

###Activity
A description of the activity performed by the subject in the form of a string.  6 different activities were performed during the study.

###Features
66 different features are available.  Each of these are numeric variables that are normalized and bounded within [-1,1].

The feature names are based on the following format:
<"t"|"f"><measurement description><"Mag"><"Mean"|"Std"><"X"|"Y"|"Z">

"t" - indicates a time based variable
"f" - indicates a frequency based variable
<measurement description> - indicates the sensor and measurement type
<"Mag"> - optional.  If present indicates a magnitude variable
<"Mean"|"Std"> - indicates whether the average is based on the mean or the standard deviation of the measurement
<"X"|"Y"|"Z"> - optional. If present ndicates the axis of motion.  Not present for magnitude.

Units for linear acceleration are in standard gravity units 'g'. The units for angular velocities are radians/second. 

###Variable Names
A full listing of all variable names is below.

subject

activity

tBodyAccMeanX

tBodyAccMeanY

tBodyAccMeanZ

tBodyAccStdX

tBodyAccStdY

tBodyAccStdZ

tGravityAccMeanX

tGravityAccMeanY

tGravityAccMeanZ

tGravityAccStdX

tGravityAccStdY

tGravityAccStdZ

tBodyAccJerkMeanX

tBodyAccJerkMeanY

tBodyAccJerkMeanZ

tBodyAccJerkStdX

tBodyAccJerkStdY

tBodyAccJerkStdZ

tBodyGyroMeanX

tBodyGyroMeanY

tBodyGyroMeanZ

tBodyGyroStdX

tBodyGyroStdY

tBodyGyroStdZ

tBodyGyroJerkMeanX

tBodyGyroJerkMeanY

tBodyGyroJerkMeanZ

tBodyGyroJerkStdX

tBodyGyroJerkStdY

tBodyGyroJerkStdZ

tBodyAccMagMean

tBodyAccMagStd

tGravityAccMagMean

tGravityAccMagStd

tBodyAccJerkMagMean

tBodyAccJerkMagStd

tBodyGyroMagMean

tBodyGyroMagStd

tBodyGyroJerkMagMean

tBodyGyroJerkMagStd

fBodyAccMeanX

fBodyAccMeanY

fBodyAccMeanZ

fBodyAccStdX

fBodyAccStdY

fBodyAccStdZ

fBodyAccJerkMeanX

fBodyAccJerkMeanY

fBodyAccJerkMeanZ

fBodyAccJerkStdX

fBodyAccJerkStdY

fBodyAccJerkStdZ

fBodyGyroMeanX

fBodyGyroMeanY

fBodyGyroMeanZ

fBodyGyroStdX

fBodyGyroStdY

fBodyGyroStdZ

fBodyAccMagMean

fBodyAccMagStd

fBodyBodyAccJerkMagMean

fBodyBodyAccJerkMagStd

fBodyBodyGyroMagMean

fBodyBodyGyroMagStd

fBodyBodyGyroJerkMagMean

fBodyBodyGyroJerkMagStd


## Licence

Use of the original dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

