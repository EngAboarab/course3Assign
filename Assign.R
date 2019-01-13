#sitting the path
pathdata = file.path("c:/users/Aboarab/Desktop/UCI")
#reading the train data
train_x = read.table(file.path(pathdata, "train", "X_train.txt"),header = FALSE)
train_y = read.table(file.path(pathdata, "train", "y_train.txt"),header = FALSE)
sub_train = read.table(file.path(pathdata, "train", "subject_train.txt"),header = FALSE)
#Reading the testing data
test_x = read.table(file.path(pathdata, "test", "X_test.txt"),header = FALSE)
test_y = read.table(file.path(pathdata, "test", "y_test.txt"),header = FALSE)
sub_test = read.table(file.path(pathdata, "test", "subject_test.txt"),header = FALSE)
#Reading the features data
features = read.table(file.path(pathdata, "features.txt"),header = FALSE)
#Reading activity labels data
activ_Labs = read.table(file.path(pathdata, "activity_labels.txt"),header = FALSE)
# Column Values for the Train table
colnames(train_x) = features[,2]
colnames(train_y) = "activId"
colnames(sub_train) = "subId"
#C column values for the test table
colnames(test_x) = features[,2]
colnames(test_y) = "activId"
colnames(sub_test) = "subId"
#colmn value for the activity labels 
colnames(activ_Labs) <- c('activId','activType')
#Merging the data
merg_train = cbind(train_y, sub_train, train_x)
merg_test = cbind(test_y, sub_test, test_x)
#merge All data
Alldata = rbind(merg_train, merg_test)
colNames = colnames(Alldata)
# subset mean and standards 
mean_std = (grepl("activId" , colNames) | grepl("subId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
Mean_Std <- Alldata[ , mean_std == TRUE]
Activity_Names = merge(Mean_Std, activ_Labs, by='activId', all.x=TRUE)
# final set 
finalSet <- aggregate(. ~subId + activId, Activity_Names, mean)
finalSet <- finalSet[order(finalSet$subId, finalSet$activId),]
# write the ouput to a text file 
write.table(finalSet, "finalSet.txt", row.name=FALSE)
