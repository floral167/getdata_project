# course project

library(reshape2)
library(plyr)
# I have downloaded the zip file, and unzipped it into the project_data folder
# read in feature file. This result in a vector of feature names with length 561
read.csv(file="~/coursera/getdata/project_data/features.txt",sep="\n", header=F) -> features

features[,1] -> header

paste(rep("V",561), c(1:561), paste="")->faked_header

# read in training data
read.fwf(file="~/coursera/getdata/project_data/train/X_train.txt", widths=rep(16,561), header=F) ->X_train
# add header in
names(X_train) <- header
#read subject and assign header to it
read.csv(file="~/coursera/getdata/project_data/train/subject_train.txt", sep=" ", header=F) -> subject_train
names(subject_train)<-c("subject")
# read label and assign header to it. 
read.fwf(file="~/coursera/getdata/project_data/train/y_train.txt", widths=c(1), header=F) ->y_train
names(y_train) n <- c("action")

# read in test file and do the same as above
read.fwf(file="~/coursera/getdata/project_data/test/X_test.txt", widths=rep(16, 561), header=F) ->X_test
names(X_test) <- header
read.csv(file="~/coursera/getdata/project_data/test/subject_test.txt", sep=" ", header=F) ->subject_test
names(subject_test)<-c("subject")
read.fwf(file="~/coursera/getdata/project_data/test/y_test.txt", widths=c(1), header=F) ->y_test
names(y_test) <-c("action")
########
# 1. Merges the training and the test sets to create one data set.
########
# combine all training related data into train
cbind(X_train, subject_train, y_train) -> train
#combine all test related data into test
cbind(X_test, subject_test,y_test) -> test
# combine test and train into data
rbind(train, test) -> data

########
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
########
#now get index of features that contain mean() or std() 
header[grepl("mean|std",header, perl=T)] -> fnames
#get rid of meanFreq and generate the columns that need to be extracted
fnames[!grepl("meanFreq",fnames,perl=T)]->mean_std_col
#adding in subject and action
c(as.character(mean_std_col), "subject", "action")->sel_col
#extract mean() and std() from data
data[,sel_col] -> selected_data

#########
# 3. Uses descriptive activity names to name the activities in the data set
#########

actions<-data.frame(c(1:6),c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
names(actions)<-c("action_id", "activity")
merge(actions, selected_data, by.x="action_id", by.y="action", all.y=T) -> m_selected_data
# remove the non descriptive variable name
m_selected_data$action_id <- NULL

##########
# 4. Appropriately labels the data set with descriptive variable names.
###########
sh <- names(m_selected_data)
# use gsub to make the variable names more readable
gsub("^\\s+\\d+", "", sh, perl=T) -> t
gsub("\\d+\\s", "", t, perl=T)->t2
gsub("\\(\\)", "",t2, perl=T)->t3
names(m_selected_data)<-t3

###### 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject
########
#now melt the data
melt(m_selected_data, id=c("activity","subject")) -> mdata
#take mean to generate the tidy data
dcast(mdata, activity+subject ~ variable, mean) -> tidy_data
write.table(tidy_data,file="~/coursera/getdata/project_tidy_data.tsv", sep="\t", quote=F,row.names=F)


