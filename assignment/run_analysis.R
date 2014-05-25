#1.Merges the training and the test sets to create one data set.
#setwd("C:/154339/KB/Courses/DSSJHU/GettingandCleaningData/assignment")
#Read training dataset
traindata <- read.table("./data/train/X_train.txt")  
trainlabel <- read.table("./data/train/y_train.txt")  
trainsubject <- read.table("./data/train/subject_train.txt")  
#Read test dataset
testdata <- read.table("./data/test/X_test.txt") 
testlabel <- read.table("./data/test/y_test.txt") 
testsubject <- read.table("./data/test/subject_test.txt")
#Combine datasets
combineddata <- rbind(traindata, testdata) #10299*561
combinedlabel <- rbind(trainlabel, testlabel)
combinedsubject <- rbind(trainsubject, testsubject)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./data/features.txt")  #561*2
meanstdidx <- grep("mean\\(\\)|std\\(\\)", features[, 2])  #66
combineddata <- combineddata[,meanstdidx] #10299*66, retain only the data which has mean/std as feature
names(combineddata) <- gsub("\\(\\)|-", "", features[meanstdidx, 2]) #Remove ( , ) & - from the label

#3.Uses descriptive activity names to name the activities in the data set
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
activitylabel <- activity[combinedlabel[, 1], 2]
combinedlabel[, 1] <- activitylabel
names(combinedlabel) <- "activity"

#4.Appropriately labels the data set with descriptive activity names. 
names(combinedsubject) <- "subject"
finaldata <- cbind(combinedsubject, combinedlabel, combineddata) #10299*68
write.table(finaldata, "finaldata.txt") 

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
subjectlength <- length(table(combinedsubject))
activitylength <- dim(activity[1])
columnlength <- dim(combineddata)[2]
resultset <- matrix(NA, nrow=subjectlength*activitylength, ncol=columnlength)
resultset <- as.data.frame(resultset)
colnames(resultset) <- colnames(combineddata)
row <- 1
for(i in 1:subjectlength) {
    for(j in 1:activitylength) {
        resultset[row, 1] <- sort(unique(combinedsubject)[, 1])[i]
        resultset[row, 2] <- activity[j, 2]
        flag1 <- i == finaldata$subject
        flag2 <- activity[j, 2] == finaldata$activity
        resultset[row, 3:columnlength] <- colMeans(finaldata[flag1&flag2, 3:columnlength])
        row <- row + 1
    }
}
write.table(resultset, "averagebysubact.txt") #write the final dataset
