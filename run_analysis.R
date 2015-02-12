run <- function()
{
  library(plyr)
  library(dplyr)
  subject_train <- read.csv("./train/subject_train.txt", colClasses = "factor", header = FALSE)
  y_train <- read.csv("./train/y_train.txt", colClasses = "factor", header = FALSE)
  x_train <- read.table("./train/X_train.txt", colClasses = "numeric", header = FALSE)
  subject_test <- read.csv("./test/subject_test.txt", colClasses = "factor", header = FALSE)
  y_test <- read.csv("./test/y_test.txt", colClasses = "factor", header = FALSE)
  x_test <- read.table("./test/X_test.txt", colClasses = "numeric", header = FALSE)
  
  x <- rbind(x_train,x_test)
  y <- rbind(y_train,y_test)
  subject <- rbind(subject_train,subject_test)
  
  featureNames <- read.table("features.txt", header = FALSE)
  names(x) <- featureNames[,2]
  columnNames <- names(x)[grep(pattern = "(mean|std)\\(\\)$", x = names(x))]
  x <- x[,columnNames]
  
  activity_labels <- read.table("activity_labels.txt", header =  FALSE, colClasses = "character")
  y[,1] <- mapvalues(y[,1], from = activity_labels[,1], to = activity_labels[,2])
  colnames(y) <- c("ActivityType")
  colnames(subject) <- c("Subject")
  data <- cbind(subject, x)
  data <- cbind(y,data)
  groupedData <- group_by(data, ActivityType, Subject)
  tidyData <- summarise_each(groupedData,funs(mean))
  write.table(tidyData, "tidydata.txt", row.name= FALSE)
}