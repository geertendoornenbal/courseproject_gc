# Course project for Getting and cleaning data

## General information
The script run_analysis.R can be used to create a tidy data set of the UCI HAR Dataset. It assums that the "UCI HAR Dataset" folder is inside the working directory when the script is run.
It outputs a tidydata.txt file containing the data in a wide-tidy format.

The data is the mean of all the mean and standard deviation columns, for each activity type and subject. A more detailed description of the variables is in the CodeBook.md file.

## Working of the script
The script has the following basic steps:
* Load the appropriate libraries
* Read all the training and test data from the UCI HAR Dataset
* Merge the training and test data together
* Select the feature columns with mean and std in their name
* Change the column names to descriptive names
* Summarize the columns with the mean function, by grouping them on activity type and subject
