The script read all the files from the test and train set, it firstly merges the x_test and x_train data, then recover the features that contain the
words -mean( and -std( in order to extract the mean and std calculations from the measurements.
Then it assigns a column name of all the subjects from test and train data. The same is done for the activities data and the measurements data.
The three variables are merged in one data frame, activities_data, and lastly, the new tidy data set is extracted grouping the data by activities, subjects and
the mean is applied to each row.

CODE BOOK 
activity - the different possible activities listed in the "activity_labels.txt" files
studentID - the different subject who performed the activity.
the remaining columns are the data of each measurements in the test and train set