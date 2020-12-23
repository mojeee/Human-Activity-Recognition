
## part 1 
file<-"./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"
subject_train<-read.table(file, dec = ".")

file1<-"./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
X_train<-read.table(file1, dec = ".")

file2<-"./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"
Y_train<-read.table(file2, dec = ".")

file3<-"./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt"
body_acc_x_train<-read.table(file3, dec = ".")

## part2

file4<-"./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"
X_test<-read.table(file4, dec = ".")

file5<-"./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"
features_label<-read.table(file5, dec = ".")

file6<-"./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"
Y_test<-read.table(file6, dec = ".")

file7<-"./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"
subject_test<-read.table(file7, dec = ".")

## part 3

X_test$activity<-Y_test
X_train$activity<-Y_train

X_test$ID<-"test"
X_train$ID<-"train"

X_test$subject<-subject_test[1]
X_train$subject<-subject_train[1]
##**************************************************
##*question1
##*
## Merges the training and the test sets to create one data set.
mergedata<-rbind(X_train,X_test)
##**************************************************
## part 4



##**************************************************
##*question4

file8<-"./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"
activity_label<-read.table(file8, dec = ".")
columnnames<-c(features_label$V2,"activity","ID","subject")
names(mergedata)<-columnnames
##**************************************************



##**********************************************************************
##*question3
mergedata[mergedata$activity==activity_label[1,1],"activity"]<-activity_label[1,2]
mergedata[mergedata$activity==activity_label[2,1],"activity"]<-activity_label[2,2]
mergedata[mergedata$activity==activity_label[3,1],"activity"]<-activity_label[3,2]
mergedata[mergedata$activity==activity_label[4,1],"activity"]<-activity_label[4,2]
mergedata[mergedata$activity==activity_label[5,1],"activity"]<-activity_label[5,2]
mergedata[mergedata$activity==activity_label[6,1],"activity"]<-activity_label[6,2]
##**********************************************************************
write.csv(mergedata,"MergeData.csv", row.names = FALSE,col.names = TRUE)


## part 5

##***************************************************************
##*question2
meand<-select(mergedata, matches("mean"))
stdd<-select(mergedata, matches("std"))
finaldata<-cbind(meand,stdd,mergedata$activity,mergedata$ID,mergedata$subject)
dataforanalysis<-cbind(meand,stdd,mergedata$activity)
##***************************************************************
write.csv(finaldata,"CleanData.csv", row.names = FALSE,col.names = TRUE)



## part6

##*********************************************
##*question 5
tidydata<-data.frame()
num<- 1:(length(dataforanalysis)-1)
for (x in num){
AC<-tapply(dataforanalysis[,x], dataforanalysis$V1, mean)
tidydata<-rbind(tidydata,AC)
names(tidydata)<- names(AC)
}
tidydata$parameter<-names(dataforanalysis[1:86])

##***********************************************
write.csv(tidydata,"TidyData.csv", row.names = FALSE,col.names = TRUE)

