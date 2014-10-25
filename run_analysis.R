#Load the 
# subject_test.txt, X_test.txt, y_test.txt, 
# subject_train.txt, X_train.txt, 
# y_train.txt, features.txt, and activity_labels.txt
#datasets
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <-  read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
xnames <- read.table("./UCI HAR Dataset/features.txt")
ylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Make sure plyr is loaded
require(plyr)

#Combine test and training data sets
subject <- rbind(subject_test, subject_train)
X <- rbind(X_test, X_train)
y <- rbind(y_test, y_train)

#Combine all datasets into data frame DT
DT <- data.frame(subject, X, y)

#Name variables using names in xnames
names(DT) <- c('id', as.character(xnames[,2]), 'activity')

#Add variable actfact containing meaningfull names for activity values
#mapvalues is from plyr
DT$actfact <- mapvalues(DT$activity, ylabels[[1]], levels(ylabels[[2]]) )

#Find column numbers for variable names that contain 'mean()' of 'std()'
DTnames <- names(DT)
meancol <- grep('mean()', DTnames, fixed=TRUE)
sdcol <- grep('std()', DTnames, fixed=TRUE)

# Get column numbers for activity and actfact
actcol <- grep('activity', DTnames, fixed=TRUE)
actfactcol <- grep('actfact', DTnames, fixed=TRUE)

#Create data frame with id, activity, actfact, and variables that contain 'mean()' of 'std()'
#as columns
DT2 <- DT[,c(1, actfactcol, meancol, sdcol)]

#Create meanDT containing means of variables that contain 'mean()' or 'std()'
#grouped by id and activity
meanDT <- aggregate(DT2[3:ncol(DT2)], by=list(DT2$id, DT2$actfact), FUN=mean)
names(meanDT)[1:2] <- c('id', 'activity')
write.table(meanDT, 'meanDT.txt')
data <- read.table('meanDT.txt', header = TRUE) 
View(data)

