library(devtools)
library("tidyr")
library("dplyr")
library(stringr)

# Load datasets
X_test <- read.table("~/R/Springboard/Springboard/Ex 3/dataset/test/X_test.txt", quote="\"", comment.char="")
X_train <- read.table("~/R/Springboard/Springboard/Ex 3/dataset/train/X_train.txt", quote="\"", comment.char="")

y_test <- read.table("~/R/Springboard/Springboard/Ex 3/dataset/test/y_test.txt", quote="\"", comment.char="")
y_train <- read.table("~/R/Springboard/Springboard/Ex 3/dataset/train/y_train.txt", quote="\"", comment.char="")

subject_test <- read.table("~/R/Springboard/Springboard/Ex 3/dataset/test/subject_test.txt", quote="\"", comment.char="")
subject_train <- read.table("~/R/Springboard/Springboard/Ex 3/dataset/train/subject_train.txt", quote="\"", comment.char="")

#1. Merges the training and the test sets to create one data set.


X_test_train <- X_test + X_train # This doesnt work.

tbl_df(X_test)
tbl_df(X_train)
View(X_test)

#2. Extracts columns containing mean and standard deviation for each measurement (Hint: Since some feature/column names are repeated, you may need to use the make.names() function in R)

#3. Creates variables called ActivityLabel and ActivityName that label all observations with the corresponding activity labels and names respectively

#4. From the data set in step 3, creates a second, independent tidy data set with the average of each variable for each activity and each subject.