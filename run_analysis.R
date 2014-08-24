if(!file.exists(dest)){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "samsung data.zip")
  unzip("samsung data.zip")
  library(tools)       
  sink("download_metadata.txt")
  print("Download date:")
  print(Sys.time() )
  print("Download URL:")
  print(target_url)
  print("Downloaded file Information")
  print(file.info(target_localfile))
  print("Downloaded file md5 Checksum")
  print(md5sum(target_localfile))
  sink()
}

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

XTotal <- rbind(x_test, x_train)
YTotal <- rbind(y_test, y_train)
featureList <- features[,2]
colnames(XTotal) <- featureList

meanData <- XTotal[,grep("mean", names(XTotal))]
stdData <- XTotal[,grep("std", names(XTotal))]
trimmedData <- cbind(meanData, stdData)
trimmedData <- cbind(YTotal, trimmedData)

trimmedData[,1] <- gsub("1", "Walking", trimmedData[,1])
trimmedData[,1] <- gsub("2", "Walking Upstairs", trimmedData[,1])
trimmedData[,1] <- gsub("3", "Walking Downstairs", trimmedData[,1])
trimmedData[,1] <- gsub("4", "Sitting", trimmedData[,1])
trimmedData[,1] <- gsub("5", "Standing", trimmedData[,1])
trimmedData[,1] <- gsub("6", "Laying", trimmedData[,1])

# Clean up the data variable names
trimmedNames <-colnames(trimmedData)
trimmedNames[1] <- "Subjects"
trimmedNames <- gsub("-|\\()", "", trimmedNames)
trimmedNames <- gsub("x", "X", trimmedNames)
trimmedNames <- gsub("z", "Z", trimmedNames)
trimmedNames <- gsub("std", "Std", trimmedNames)
trimmedNames <- gsub("mean", "Mean", trimmedNames)
trimmedNames <- gsub("BodyBody", "Body", trimmedNames)
colnames(trimmedData) <- trimmedNames

trimmedData[,2:80] <- as.data.frame(sapply(trimmedData[,2:80], as.numeric))


# subset the data for averages of mean/std 
walkingSubset <- subset(trimmedData, Subjects == "Walking")
walkingUpSubset <- subset(trimmedData, Subjects == "Walking Upstairs")
walkingDownSubset <- subset(trimmedData, Subjects == "Walking Downstairs")
sittingSubset <- subset(trimmedData, Subjects == "Sitting")
standingSubset <- subset(trimmedData, Subjects == "Standing")
layingSubset <- subset(trimmedData, Subjects == "Laying")

walkingAverages <- colMeans(walkingSubset[,2:80], na.rm=FALSE)
walkingUpAverages <- colMeans(walkingUpSubset[,2:80], na.rm=FALSE)
walkingDownAverages <- colMeans(walkingDownSubset[,2:80], na.rm=FALSE)
sittingAverages <- colMeans(sittingSubset[,2:80], na.rm=FALSE)
standingAverages <- colMeans(standingSubset[,2:80], na.rm=FALSE)
layingAverages <- colMeans(layingSubset[,2:80], na.rm=FALSE)

# Add averages to a new data frame, and name the rows the activity types
averagedData <- rbind(walkingAverages,walkingUpAverages,walkingDownAverages,sittingAverages,standingAverages,layingAverages)
names <- c("WalkingAverage", "WalkingUpAverage", "WalkingDownAverage", "SittingAverage", "StandingAverage", "LayingAverage")
averagedData <- cbind(names, averagedData)

#Rotate dataset to make it more tidy -- transposing data frame and naming columns
tidyAveragedData <- as.data.frame(t(averagedData[,-1]))

# Write dataset to txt file
write.table(tidyAveragedData, "Variable Averages by Type.txt", row.names=FALSE)







