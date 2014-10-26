## Introduction

This document explains how all of the scripts work and how they are connected.

* <b>Raw data</b>: To run the R script, please create under your home directory: ~/coursera/getdata. The unzipped data goes under "~/coursera/getdata/project_data". 

* <b>Package need to be installed</b>: reshape2 

* <b>Description</b>: read.fwf is used on X_train.txt, y_train.txt, X_test.txt and y_test.txt. read.csv is used on the subject_train.txt and subject_test.txt files. The header file is simply read from features.txt. The header will be cleaned up later.


The following describes how to do the 5 tasks of the project: 
<ol>
<li><b>Merges the training and the test sets to create one data set</b>: cbind and rbind are used to combine data together </li>
<li><b>Extracts only the measurements on the mean and standard deviation for each measurement</b>: Here grepl is used to get the names contain mean() and std(). meanFreq is filtered out since it is a different measurement. </li>
<li><b>Uses descriptive activity names to name the activities in the data set</b>: here c(1:6) is replaced by c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING") to make the activities easier to understand. The column name is renamed to activity from action as well</li>
<li><b>Appropriately labels the data set with descriptive variable names.</b>:gsub is used to remove parenthesis and other non alpha letters </li>
<li><b>From the data set in step 4, creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject</b>: melt and dcast is used to generate mean for each unique combination of subject and activity. The output file is written to ~/coursera/getdata/project_tidy_data.tsv with tab used as separater </li>
</ol>







When loading the dataset into R, please consider the following:

* The dataset has 2,075,259 rows and 9 columns. First
calculate a rough estimate of how much memory the dataset will require
in memory before reading into R. Make sure your computer has enough
memory (most modern computers should be fine).

* We will only be using data from the dates 2007-02-01 and
2007-02-02. One alternative is to read the data from just those dates
rather than reading in the entire dataset and subsetting to those
dates.

* You may find it useful to convert the Date and Time variables to