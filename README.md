GCD_project
===========

**Note this program requires the plyr package be available in the R environment***

Description and location of source data (from assignment)

"One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "

Description of run_analysis.R

This program does the following:
Loads the subject_test.txt, X_test.txt, y_test.txt, subject_train.txt, X_train.txt, y_train.txt, features.txt, and activity_labels.txt datasets into data frames namedrespectively,

subject_test
X_test 
y_test 
subject_train
X_train 
y_train 
xnames 
ylabels 


It then combines the three pairs of test and training data sets into 3 combined data frames, i.e.

The subject contains the rows of both subject_test and subject_train, the X  data frame contains the rows of both X_test, X_train, and y contains the rows y_test, y_train.

The three resuting data frames are then combined into a single data frame called DT.


In order to make DT easier to use, we assign the column containg subject the name 'id', the column containing y the name 'activity', and the columns of X the labels contained in the second column of xnames.
names(DT) <- c('id', as.character(xnames[,2]), 'activity')

A variable actfact containing meaningfull names for activity values from ylabels is created and added to DT using 
mapvalues is from plyr
DT$actfact <- mapvalues(DT$activity, ylabels[[1]], levels(ylabels[[2]]) )

Using grep, we find column numbers for variable names that contain 'mean()' of 'std()'
and create a new data frame DT2 that only contain id, the name of the activity, and columns from DT that have 
mean() or std() in the name. 

The aggregate function is then used on DT2 to calculate a new data frame meanDT containing means of variables that contain 'mean()' of 'std()' grouped by id and activity

Finally, the meanDT is written to a text file called meanDT.txt.  In order to confirm the file was created correctly, meanDT.txt is then read from disk, and the resulting data frame is displayed.


