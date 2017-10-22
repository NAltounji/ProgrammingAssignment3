#Load needed packages
library(data.table)
library(dplyr)
library(reshape2)

#First, set your work directory with the setwd() command
#Now let's download and unzip the file
if(!file.exists("GaCDCP")) dir.create("GaCDCP")
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file( url = url1 , destfile = "GaCDCP/UCI HAR Dataset.zip")
unzip(zipfile="GaCDCP/UCI HAR Dataset.zip" , exdir="GaCDCP")

#Second, create datasets and modify its col names, then we merge test datasets, merge train datasets, and merge both results together, by doing the following steps, we would be accomplished step 1 and 4
features <- read.table("GaCDCP/UCI HAR Dataset/features.txt")
activitylabels <- read.table("GaCDCP/UCI HAR Dataset/activity_labels.txt")
colnames(activitylabels) <- c("actid","type") #changing variables names to use them in Step 4
Xtest <- read.table("GaCDCP/UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("GaCDCP/UCI HAR Dataset/test/y_test.txt")
subtest <- read.table("GaCDCP/UCI HAR Dataset/test/subject_test.txt")
Xtrain <- read.table("GaCDCP/UCI HAR Dataset/train/X_train.txt")
Ytrain <- read.table("GaCDCP/UCI HAR Dataset/train/y_train.txt")
subtrain <- read.table("GaCDCP/UCI HAR Dataset/train/subject_train.txt")
colnames(Xtest) <- features[,2]
colnames(Ytest) <- "actid"
colnames(subtest) <- "subid"
testdata <- cbind(subtest,Ytest,Xtest)
colnames(Xtrain) <- features[,2]
colnames(Ytrain) <- "actid"
colnames(subtrain) <- "subid"
traindata <- cbind(subtrain,Ytrain,Xtrain)
fulldata <- rbind(traindata,testdata) #final data of merging test and train datasets

#Third, extract only variables of mean and standard deviation to finish Step 2
meansddata <- fulldata[,(grepl("actid" , colnames(fulldata)) | 
                           grepl("subid" , colnames(fulldata)) | 
                           grepl("mean.." , colnames(fulldata)) | 
                           grepl("std.." , colnames(fulldata)) )]

#do Step 3 to give to names to activities, use activitylabel dataset to do it because this dataset contain activities' names
meansddata <- merge(meansddata,activitylabels, by = "actid" , all.x = T)

#At last, use aggregate to create a dataset of the means and standard deviations for each var., then save it into a new file txt formatted
avgdata <- aggregate(. ~ actid + subid , meansddata , mean)
avgdata <- avgdata[order(avgdata$subid,avgdata$actid),]
if(!file.exists("GaCDCP/UCI HAR Dataset/avgdata")) dir.create("GaCDCP/UCI HAR Dataset/avgdata")
write.table(avgdata, "GaCDCP/UCI HAR Dataset/avgdata/avgdata.txt" , row.names = F)
