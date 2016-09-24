### Coursera Getting & Cleaning Data Project Week 4
### Sylwester Dec

### runAnalysis.r - Description

# 1. Read data files
# 2. Uses descriptive activity names to name the activities in the data set and
#    appropriately labels the data set with descriptive variable names.
# 3. Merges the training and the test sets to create one data set.
# 4. Extracts only the measurements on the mean and standard deviation for each measurement.
# 5. Use descriptive activity names to name the activities in the data set
# 6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 7. Write output tidy data

### STEP 1 - download & read data sources 

# set workspace to file diretory
setwd("D:/Documents/R-workdir/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

# Check Workspace
getwd()

#list files
list.files()


# Read FEATURE table and set Labels
features <- read.table("features.txt")
                       
# Read ACTIVITY table                       
activity <- read.table("activity_labels.txt")


# Read Train set
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

#Read Test set
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")


###  Step 2  - Assigin column names to the data imported above
colnames(activity)  = c('activityId','activityType');

colnames(subject_train)  = "subjectId";
colnames(subject_test)  = "subjectId";

colnames(y_train)        = "activityId";
colnames(y_test)        = "activityId";


#  use descriptive colnames for measures from feature dictionary
colnames(x_train)        = features[,2]; 
colnames(x_test)        = features[,2]; 


### Step 3 - Merge data sets

# Create the test set by unoin y_test, x_test, subject_test
testdata = cbind(y_test, subject_test,x_test);

# Create the training set by union y_train, x_train, subject_train
traindata = cbind(y_train, subject_train,x_train);

# Create the final data : union test and training datasets
finaldata = rbind(traindata,testdata);


### Step 4 Extract only measurements : mean and standard deviation for each variable

# Vector of column names
columnnames<-names(finaldata)

#  find mean and std
ms <- grep("mean|std",columnnames)

# Create Extract for mean and std
extractdata <- finaldata[,c(1,2,ms)]

### Step 5 Use descriptive activity names to name the activities in the data set

# Merge data with Activity dictionary
mergedata <- merge(activity, extractdata, by="activityId")

# cut activityId
mergedata <- mergedata[,-1]

### Step 6 - Final data set -average for each activity and subject

# Calculate  means
finaldata <- aggregate(mergedata, by=list('Activity'=mergedata$activityType,'Subject'=mergedata$subjectId), FUN=mean )

# Remove duplicated columns 
finaldata<-finaldata[,-c(3,4)]

### Step 7 Write final data setto file

write.table(finaldata, "averages_data.txt")


