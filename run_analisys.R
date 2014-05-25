## 1 - Merges the training and the test sets to create one data set.

## Read trainning tables

trainData <- read.table("./train/X_train.txt")
trainHeader <- read.table("./train/y_train.txt")
trainSubject <- read.table("./train/subject_train.txt")

## Read testing tables

testData <- read.table("./test/X_test.txt")
testHeader <- read.table("./test/y_test.txt") 
testSubject <- read.table("./test/subject_test.txt")

## Join data

jData <- rbind(trainData, testData)
jHeader <- rbind(trainHeader, testHeader)
jSubject <- rbind(trainSubject, testSubject)

## 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 

## Read features table

feat <- read.table("./features.txt")

## Select only mean and std and correct variable names

msdIndex <- grep("mean\\(\\)|std\\(\\)", feat[, 2])
jData <- jData[, msdIndex]

names(jData) <- gsub("\\(\\)", "", feat[msdIndex, 2])
names(jData) <- gsub("mean", "Mean", names(jData))
names(jData) <- gsub("std", "Std", names(jData))
names(jData) <- gsub("-", "", names(jData)) 


## 3 - Uses descriptive activity names to name the activities in the data set

# Read activity table

act <- read.table("./activity_labels.txt")

## Change number activity to string

act[, 2] <- tolower(gsub("_", "", act[, 2]))
substr(act[2, 2], 8, 8) <- toupper(substr(act[2, 2], 8, 8))
substr(act[3, 2], 8, 8) <- toupper(substr(act[3, 2], 8, 8))
actName <- act[jHeader[, 1], 2]
jHeader[, 1] <- actName
names(jHeader) <- "activity"


## Appropriately labels the data set with descriptive activity names. 

names(jSubject) <- "subject"
mergedData <- cbind(jSubject, jHeader, jData)
write.table(mergedData, "merged.txt")


## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

sbjLen <- length(table(jSubject))
actLen <- dim(act)[1]
colLen <- dim(mergedData)[2]
data <- matrix(NA, nrow=sbjLen*actLen, ncol=colLen) 
data <- as.data.frame(data)
colnames(data) <- colnames(mergedData)
r <- 1
for(i in 1:sbjLen) {
    for(j in 1:actLen) {
        data[r, 1] <- sort(unique(jSubject)[, 1])[i]
        data[r, 2] <- act[j, 2]
        a <- i == mergedData$subject
        b <- act[j, 2] == mergedData$activity
        data[r, 3:colLen] <- colMeans(mergedData[a&b, 3:colLen])
        r <- r + 1
    }
}
write.table(data, "average_data.txt")
