Getting and Cleaning Data Project
Week 4
Sylwester Dec

Overview  
Project for manipulating and cleaning data in R


Source Data

The data used in project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.r script  perform following steps:
1. Download data sources to new directory
features.txt
activity_labels.txt
subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt

You can customize folder and path in line 15.

2. Assign Activity names and descriptive variable names to data sets
Read two files with labels :  activity_labels.txt and features.txt and assing values to dataset columns.

3. Merge the training and the test sets to create one data set.
Merge (union) all data files to create one data file. 

4. Extracts only the measurements on the mean and standard deviation for each measurement.
Using grep find all columns with 'mean' and 'std' in the column name, then remove all other column except 2 first columns with activity and subject identifiers

5. Use descriptive activity names to name the activities in the data set
Merge activity_labels.txt with data set and replace activityId with Activity name


6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Calculate average for all measurement columns group by Activity and Subject 

7. Write output tidy data to csv file average_data.txt