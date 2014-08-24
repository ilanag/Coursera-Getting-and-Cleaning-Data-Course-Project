README.md

###Coursera - Getting and Cleaning Data
###Course Project
###Samsung Data

#Overview
##Purpose
The objective of this exercise was to obtain, merge, and clean an extisting dataset 
from which to create a new dataset. 

##Data
The data used in this exercise was from the Smartlab at Universita Degli di Studi di Genova,
and pertains to data collected by the accelerometer and gyroscope in Samsung phones.

The data combined included the raw data from the following files:
-x_test.txt
-x_train.txt
-y_test.txt
-y_train.txt
-features.txt

#Transformations
The following considerations were made in the cleaning and merging of this dataset
- The dimensions of each raw dataset
- The number of columns/rows of each dataset
- Clarity in reading

The following transformations were made:
- The datasets were combined, first the x_train.txt and X_test.txt, as well as the Y_test.txt 
and y_train.txt. These were then all combined together.
- The headings and column rows were transformed to be in camel caps (i.e. fBodyAcc) for easier
reading
- Headings with duplicate words (i.e. BodyBody) were replaced
- Only data pertaining to the mean and standard deviation values was selected, from which a new 
dataset was created
- The values in y_test.txt and y_train.txt were converted to their string values, as defined
in the features.txt file
- The columns (as applicable) were converted to numeric values from which means were taken, and 
placed into a new dataset
- The dataset was transposed for easier reading

