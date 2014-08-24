## Read in Features
featuresTable <- read.table("./Data/features.txt", sep=" ", header=FALSE)
features <- featuresTable$V2
## Read in Activity Labels
activityLabels <- read.table("./Data/activity_labels.txt", sep=" ", header=FALSE)

## Load Training Data
subject_train <- scan("./Data/train/subject_train.txt")
y_train <- scan("./Data/train/y_train.txt")
activities <- sapply(y_train, function(val) { activityLabels$V2[activityLabels$V1 == val]})
x_train <- read.table("./Data/train/x_train.txt")
names(x_train) <- features
x_train <- cbind(activities, x_train)
x_train <- cbind(subject_train, x_train)
names(x_train)[1] <- "Subject_ID"
names(x_train)[2] <- "Activity"

## Load Test Data
subject_test <- scan("./Data/test/subject_test.txt")
y_test <- scan("./Data/test/y_test.txt")
activities <- sapply(y_test, function(val) { activityLabels$V2[activityLabels$V1 == val]})
x_test <- read.table("./Data/test/x_test.txt")
names(x_test) <- features
x_test <- cbind(activities, x_test)
x_test <- cbind(subject_test, x_test)
names(x_test)[1] <- "Subject_ID"
names(x_test)[2] <- "Activity"

## Merge Train and Test Data
allowedColumns <- c("Subject_ID","Activity"
                    ,"tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z"          
                    ,"tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z"           
                    ,"tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z"       
                    ,"tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z"        
                    ,"tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z"      
                    ,"tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z"       
                    ,"tBodyGyro-mean()-X","tBodyGyro-mean()-Y","tBodyGyro-mean()-Z"
                    ,"tBodyGyro-std()-X","tBodyGyro-std()-Y","tBodyGyro-std()-Z"          
                    ,"tBodyGyroJerk-mean()-X","tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z"     
                    ,"tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z"      
                    ,"tBodyAccMag-mean()","tBodyAccMag-std()"          
                    ,"tGravityAccMag-mean()","tGravityAccMag-std()"       
                    ,"tBodyAccJerkMag-mean()","tBodyAccJerkMag-std()"      
                    ,"tBodyGyroMag-mean()","tBodyGyroMag-std()"         
                    ,"tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()"     
                    ,"fBodyAcc-mean()-X","fBodyAcc-mean()-Y","fBodyAcc-mean()-Z"          
                    ,"fBodyAcc-std()-X","fBodyAcc-std()-Y","fBodyAcc-std()-Z"           
                    ,"fBodyAccJerk-mean()-X","fBodyAccJerk-mean()-Y","fBodyAccJerk-mean()-Z"      
                    ,"fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y","fBodyAccJerk-std()-Z"       
                    ,"fBodyGyro-mean()-X","fBodyGyro-mean()-Y","fBodyGyro-mean()-Z"         
                    ,"fBodyGyro-std()-X","fBodyGyro-std()-Y","fBodyGyro-std()-Z"          
                    ,"fBodyAccMag-mean()","fBodyAccMag-std()"          
                    ,"fBodyBodyAccJerkMag-mean()","fBodyBodyAccJerkMag-std()"  
                    ,"fBodyBodyGyroMag-mean()","fBodyBodyGyroMag-std()"     
                    ,"fBodyBodyGyroJerkMag-mean()","fBodyBodyGyroJerkMag-std()"                     
                    )
tidiedData <- rbind(subset(x_train, select=allowedColumns),
                    subset(x_test, select=allowedColumns))

## Create Averaged Data Set
averagedTidiedData <- melt(tidiedData, id=c("Subject_ID","Activity"), na.rm=TRUE)
averagedTidiedData <- dcast(averagedTidiedData, Subject_ID + Activity ~ variable, mean)
names(averagedTidiedData)[3:length(names(averagedTidiedData))] <-
  paste("Average", names(averagedTidiedData)[3:length(names(averagedTidiedData))])

## Output
write.csv(tidiedData, "TidyData.csv")
write.csv(averagedTidiedData, "AveragedTidyData.csv")