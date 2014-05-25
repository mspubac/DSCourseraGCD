Getting and Cleaning Data - Peer Assignment
===========================================

1. Download the dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Read the traning data, label and subject
3. Read the test data, label and subject
4. Filter only mean, std data from the combined (training, test) dataset
	- Read the features data
	- Identify the mean, std index using grep
	- Filter the mean, std data from the combined dataset
	- Assign label using features for the mean,std dataset by removing (, ) and -
5. Assign activity label
	- Assign the label by removing _ and converting to lowecase
6. Write the final dataset into to a file (finaldata.txt)
7. Generate the average of mean/std for the finaldataset (averagebysubact.txt)