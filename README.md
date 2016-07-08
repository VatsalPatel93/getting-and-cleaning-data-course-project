##Getting and Cleaning Data - Project
This is the README file for course project of the Getting and Cleaning Data Coursera course. 

* The R script, run_analysis.R, assuming the working directory contains the folder UCI HAR DATASET folder containing all the data files, does the following:

1. Load the activity and feature info
2. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation for each measurement
3. Loads the activity and subject data for each dataset, and merges those columns with the dataset
4. Merges the train and test datasets
5. Transforms the activity and subject columns into factors
6. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result of the script is shown in the file tidy.txt.