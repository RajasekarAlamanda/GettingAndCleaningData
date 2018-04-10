rm(list = ls())
setwd("~/Rajasekar Alamanda/KC/R/Coursera - Data Science/Getting and Cleaning Data/Project")
getwd()

#download data
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest <- "Dataset.zip"
download.file(fileurl, destfile = dest)

#unzip
unzip(dest, files = NULL, list = FALSE, overwrite = TRUE, exdir = ".", unzip = "internal")

#list of files
dataset_path <- file.path(".","UCI HAR Dataset")
files <- list.files(dataset_path,recursive = TRUE) # recursive opens files from subfolders
files

# read features files
features_train <- read.table(file.path(dataset_path, "train", "X_train.txt"),header = FALSE)
features_test <- read.table(file.path(dataset_path, "test", "X_test.txt"),header = FALSE)

# read subject files
subject_train <- read.table(file.path(dataset_path, "train", "subject_train.txt"),header = FALSE)
subject_test <- read.table(file.path(dataset_path, "test", "subject_test.txt"),header = FALSE)

# read activity files
activity_train <- read.table(file.path(dataset_path, "train", "Y_train.txt"),header = FALSE)
activity_test <- read.table(file.path(dataset_path, "test", "Y_test.txt"),header = FALSE)

#Merge training and test datasets
activity <- rbind(activity_train,activity_test)
subject <- rbind(subject_train, subject_test) 
features <- rbind(features_train, features_test)


#assign variable names
names(subject) <- c("subject")
names(activity) <- c("activity")
featurenames <- read.table(file.path(dataset_path,"features.txt"), head = FALSE)
names(features) <- featurenames$V2

# merge columns to get all data
dataAll <- cbind(subject, activity)
dataAll <- cbind(features, dataAll)
head(dataAll)
names(dataAll)
str(dataAll)
#means and sd only
subsetFeature <- featurenames$V2[grep("mean\\(\\)|std\\(\\)", featurenames$V2)]
str(subsetFeature)
head(subsetFeature)

activitylabels <- read.table(file.path(dataset_path,"activity_labels.txt"), header = FALSE)
activitylabels
head(dataAll$activity)

#find and replace short forms with names
#prefix t is replaced by time
#Acc is replaced by Accelerometer
#Gyro is replaced by Gyroscope
#prefix f is replaced by frequency
#Mag is replaced by Magnitude
#BodyBody is replaced by Body
names(dataAll) <- gsub("^t", "time", names(dataAll))
names(dataAll) <- gsub("^f", "frequency", names(dataAll))
names(dataAll) <- gsub("^Acc", "Accelerometer", names(dataAll))
names(dataAll) <- gsub("^gyro", "gyroscope", names(dataAll))
names(dataAll) <- gsub("^Mag", "magnitude", names(dataAll))
names(dataAll) <- gsub("^BodyBody", "body", names(dataAll))
head(dataAll)

# tidy data 
library(dplyr)
tidydata <- aggregate(. ~subject+activity, dataAll, mean)
tidydata <- tidydata[order(tidydata$subject, tidydata$activity),]
str(tidydata)
write.table(tidydata, file = "tidydata.txt",row.name = FALSE)
