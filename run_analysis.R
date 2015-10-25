library(dplyr)
#reading data
dir <- "UCI HAR Dataset/"
dirtest <- "UCI HAR Dataset/test/"
x_test <- read.table(paste(dirtest, "X_test.txt", sep=""))
y_test <- read.table(paste(dirtest, "y_test.txt", sep=""))
sub_test <- read.table(paste(dirtest, "subject_test.txt", sep=""))

dirtrain <- "UCI HAR Dataset/train/"
x_train <- read.table(paste(dirtrain, "X_train.txt", sep=""))
y_train <- read.table(paste(dirtrain, "y_train.txt", sep=""))
sub_train <- read.table(paste(dirtrain, "subject_train.txt", sep=""))

#merging test and train measurements
all <- rbind(x_test, x_train)

#recovering the features related to mead and std
all_labels <- read.table(paste(dir, "features.txt", sep=""))
mean_std_labels <- filter(all_labels, grepl("-mean\\(|-std\\(", V2))
#index of the features
list <- mean_std_labels[,1]
#labels of the features
labels <- mean_std_labels[,2]
#subsetting the data
data <- select(all, num_range("V", list))
#assigning colum names
names(data) <- labels

#adding the activity data
activity_labels <- read.table(paste(dir, "activity_labels.txt", sep=""))
y_all <- rbind(y_test, y_train)
y_all$V1 <- as.factor(activity_labels$V2[y_all$V1])


activities_data <- cbind(y_all, data)
names(activities_data)[names(activities_data)=="V1"] <- "activity"
#adding the subject data
sub_all <- rbind(sub_test, sub_train)
activities_data <- cbind(sub_all, activities_data)
names(activities_data)[names(activities_data)=="V1"] <- "studentID"
#new subset 
new_table <- activities_data %>% group_by(activity, studentID) %>% summarise_each(funs(mean))

new_table