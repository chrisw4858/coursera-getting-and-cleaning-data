# Coursera Getting and Cleaning Data Course Project
The following provides a solution for the Johns Hopkins Getting and Cleaning Data project, June 2015.

## Goals

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

You should create one R script called run_analysis.R that does the following. 

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## What you will find

* **README.md**         - This file
* **CodeBook.md**       - Description of the analysis and variables
* **run_analysis.R**    - R script to perform the analysis
* LICENSE.md            - License for contents
* .gitignore            - GitHub default for R

## How to run the script
1. Clone this repository: `git clone git@github.com:chrisw4858/coursera-getting-and-cleaning-data.git`
2. Download the data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
3. Uncompress the data file and copy the directory "UCI HAR Dataset"" to the root directory of the cloned repository i.e. `run_analysis.R` and "UCI HAR Dataset" should be in the same parent folder.
4. Open RStudio and set the working directory (setwd()) to the root directory of the cloned repository.
5. Run the analysis by typing `source("run_analysis.R")` into the console window of RStudio.  (Alternatively the script can be run from the repository root directory on the command line via `Rscript run_analysis.R`)
6.  The file "overall_averages_wide.txt" will be created in the repository root directory.
7.  The data set can be read into R via `averages = read.table( "overall_averages_wide.txt", header=TRUE, stringsAsFactors=FALSE)` to obtain a data frame with 180 obs. and 68 variables.
