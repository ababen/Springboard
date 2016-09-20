library(devtools)
library("tidyr")
library("dplyr")
library(stringr)

setwd("C:/Users/ababen/OneDrive/Documents/R/Springboard/Springboard/Ex 3")

# Load datasets
x_test <- read.table("dataset/test/X_test.txt", quote="\"", comment.char="")
x_train <- read.table("dataset/train/X_train.txt", quote="\"", comment.char="")

y_test <- read.table("dataset/test/y_test.txt", quote="\"", comment.char="")
y_train <- read.table("dataset/train/y_train.txt", quote="\"", comment.char="")

subject_test <- read.table("dataset/test/subject_test.txt", quote="\"", comment.char="")
subject_train <- read.table("dataset/train/subject_train.txt", quote="\"", comment.char="")

features <- read.table("dataset/features.txt", quote="\"", comment.char="")

#1. Merges the training and the test sets to create one data set.

x_test$dataset <- "test"
x_train$dataset <- "train"
y_test$dataset <- "test"
y_train$dataset <-"train"
subject_test <- "test"
subject_train <- "train"


ds_X <- rbind(x_test,x_train)
ds_Y <- rbind(y_test,y_train)
ds_subj <- rbind(subject_test,subject_train)
rm(x_test, x_train, y_test, y_train, subject_test, subject_train)

#2. Extracts columns containing mean and standard deviation for each measurement
#(Hint: Since some feature/column names are repeated, you may need to use the
#make.names() function in R)


names(ds_X) <- features$V2
make.names(ds_X)

#3. Creates variables called ActivityLabel and ActivityName that label all
#observations with the corresponding activity labels and names respectively

names(ds_Y)[names(ds_Y)=="V1"] <- "ActivityLabel"

ds_Y$ActivityName <-  ifelse(ds_Y$ActivityLabel == "1", "WALKING", 
                        ifelse(ds_Y$ActivityLabel == "2", "WALKING_UPSTRAIRS",
                          ifelse(ds_Y$ActivityLabel == "3", "WALKING_DOWNSTAIRS", 
                            ifelse(ds_Y$ActivityLabel == "4", "SITTING", 
                              ifelse(ds_Y$ActivityLabel == "5", "STANDING", 
                                ifelse(ds_Y$ActivityLabel == "6", "LAYING",NA))))))


#4. From the data set in step 3, creates a second, independent tidy data set
#with the average of each variable for each activity and each subject.