run <- function()
{
  # load necessary libraries
  library(plyr)
  library(dplyr)
  
  # load all data
  subject_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt", colClasses = "factor", header = FALSE)
  y_train <- read.csv("./UCI HAR Dataset/train/y_train.txt", colClasses = "factor", header = FALSE)
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", colClasses = "numeric", header = FALSE)
  subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt", colClasses = "factor", header = FALSE)
  y_test <- read.csv("./UCI HAR Dataset/test/y_test.txt", colClasses = "factor", header = FALSE)
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", colClasses = "numeric", header = FALSE)
  
  # merge train and test data together
  x <- rbind(x_train,x_test)
  y <- rbind(y_train,y_test)
  subject <- rbind(subject_train,subject_test)
  
  # give features corresponding names
  featureNames <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
  names(x) <- featureNames[,2]
  # only use the columnnames with mean and std
  columnNames <- names(x)[grep(pattern = "(mean|std)", x = names(x))]
  x <- x[,columnNames]
  
  # map the descriptive activity labels onto the data
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header =  FALSE, colClasses = "character")
  y[,1] <- mapvalues(y[,1], from = activity_labels[,1], to = activity_labels[,2])
  
  # add descriptive names to the remaining columns
  colnames(y) <- c("ActivityType")
  colnames(subject) <- c("Subject")
  
  # bind them all together
  data <- cbind(subject, x)
  data <- cbind(y,data)
  
  # group the data on activity and subject
  groupedData <- group_by(data, ActivityType, Subject)
  #summarise each column with the mean function
  tidyData <- summarise_each(groupedData,funs(mean))
  
  write.table(tidyData, "tidydata.txt", row.name= FALSE)
}