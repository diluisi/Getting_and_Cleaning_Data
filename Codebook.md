This Codebook describes the variables, the data, and any transformations or work that you performed to clean up the data. 

Data source webpage: </url>http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones</url> 

Data for the project: </url> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</url>

run_analysis.R
===============

Step-by-step:

1-Merges the training and the test sets to create one data set.

  * Read all data from directory (_X_train.txt_, _y_train.txt_, _subject_train.txt_, _X_test.txt_, _y_test.txt_ and _subject_test.txt_) and create new variables to store them (_trainData_, _trainHeader_, _trainSubject_, _testData_, _testHeader_, _testSubject_).
  * Combine each dataset (train data with test data, trai header with test header, train subject with test subject) in order to create only one with train and test data. Each joined dataset is stored on _jData_,_jHeader_ and _jSubject_.
  * The merged data will be generated at the 4th step.

2-Extracts only the measurements on the mean and standard deviation for each measurement. 

 * Read _features.txt_ and select only columns with mean and standard deviation

3-Uses descriptive activity names to name the activities in the data set

 * Read _activity_labels.txt_ and convert number activity to string.

4-Appropriately labels the data set with descriptive activity names. 

 * Combine all data sets (_jData_, _jHeader_ and jSubject_) and create one data set merged (_merged.txt_).
 
5-Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 



