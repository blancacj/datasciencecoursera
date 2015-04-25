## read data files
##############
body_acc_x_train<-read.table('./train/Inertial Signals/body_acc_x_train.txt')
body_acc_y_train<-read.table('./train/Inertial Signals/body_acc_y_train.txt')
body_acc_z_train<-read.table('./train/Inertial Signals/body_acc_z_train.txt')
body_gyro_x_train<-read.table('./train/Inertial Signals/body_gyro_x_train.txt')
body_gyro_y_train<-read.table('./train/Inertial Signals/body_gyro_y_train.txt')
body_gyro_z_train<-read.table('./train/Inertial Signals/body_gyro_z_train.txt')
total_acc_x_train<-read.table('./train/Inertial Signals/total_acc_x_train.txt')
total_acc_y_train<-read.table('./train/Inertial Signals/total_acc_y_train.txt')
total_acc_z_train<-read.table('./train/Inertial Signals/total_acc_z_train.txt')

#############
subject_train<-read.table('./train/subject_train.txt')
X_train<-read.table('./train/X_train.txt')
Y_train<-read.table('./train/Y_train.txt')

#############
subject_test<-read.table('./test/subject_test.txt')
X_test<-read.table('./test/X_test.txt')
Y_test<-read.table('./test/Y_test.txt')

#############
body_acc_x_test<-read.table('./test/Inertial Signals/body_acc_x_test.txt')
body_acc_y_test<-read.table('./test/Inertial Signals/body_acc_y_test.txt')
body_acc_z_test<-read.table('./test/Inertial Signals/body_acc_z_test.txt')
body_gyro_x_test<-read.table('./test/Inertial Signals/body_gyro_x_test.txt')
body_gyro_y_test<-read.table('./test/Inertial Signals/body_gyro_y_test.txt')
body_gyro_z_test<-read.table('./test/Inertial Signals/body_gyro_z_test.txt')
total_acc_x_test<-read.table('./test/Inertial Signals/total_acc_x_test.txt')
total_acc_y_test<-read.table('./test/Inertial Signals/total_acc_y_test.txt')
total_acc_z_test<-read.table('./test/Inertial Signals/total_acc_z_test.txt')

## step 1: merge the training and test sets to create one data set

body_acc_x_test_train<-rbind(body_acc_x_test,body_acc_x_train)
body_acc_y_test_train<-rbind(body_acc_y_test,body_acc_y_train)
body_acc_z_test_train<-rbind(body_acc_z_test,body_acc_z_train)

body_gyro_x_test_train<-rbind(body_gyro_x_test,body_gyro_x_train)
body_gyro_y_test_train<-rbind(body_gyro_y_test,body_gyro_y_train)
body_gyro_z_test_train<-rbind(body_gyro_z_test,body_gyro_z_train)

total_acc_x_test_train<-rbind(total_acc_x_test,total_acc_x_train)
total_acc_y_test_train<-rbind(total_acc_y_test,total_acc_y_train)
total_acc_z_test_train<-rbind(total_acc_z_test,total_acc_z_train)

##
X_test_train<-rbind(X_test,X_train)
Y_test_train<-rbind(Y_test,Y_train)
subject_test_train<-rbind(subject_test,subject_train)

## create ./test_train/Interial Signals and write all the merged data into the file
dir.create(file.path("test_train","Inertial Signals"),recursive=TRUE)

write.table(X_test_train,'./test_train/X.txt',row.name=FALSE)
write.table(Y_test_train,'./test_train/Y.txt',row.name=FALSE)
write.table(subject_test_train,'./test_train/subject.txt',row.name=FALSE)

write.table(body_acc_x_test_train,'./test_train/Inertial signals/body_acc_x.txt',row.name=FALSE)
write.table(body_acc_y_test_train,'./test_train/Inertial signals/body_acc_y.txt',row.name=FALSE)
write.table(body_acc_z_test_train,'./test_train/Inertial signals/body_acc_z.txt',row.name=FALSE)

write.table(body_gyro_x_test_train,'./test_train/Inertial signals/body_gyro_x.txt',row.name=FALSE)
write.table(body_gyro_y_test_train,'./test_train/Inertial signals/body_gyro_y.txt',row.name=FALSE)
write.table(body_gyro_z_test_train,'./test_train/Inertial signals/body_gyro_z.txt',row.name=FALSE)

write.table(total_acc_x_test_train,'./test_train/Inertial signals/total_acc_x.txt',row.name=FALSE)
write.table(total_acc_y_test_train,'./test_train/Inertial signals/total_acc_y.txt',row.name=FALSE)
write.table(total_acc_z_test_train,'./test_train/Inertial signals/total_acc_z.txt',row.name=FALSE)
##


library(dplyr)

## step 2: extract only the measurements on the mean and standard deviation for each measurement

features<-read.table('features.txt')
cc<-grep("mean|std",features$V2);
X_test_train_select<-X_test_train[,cc] 


## step 3: Use descriptive activity names to name the activities in the data set
activity_labels<-read.table('activity_labels.txt')
Y_test_train_join<-join(Y_test_train,activity_labels,by="V1")
Y_test_train<-data.frame(Y_test_train_join[,-1])


## step 4: label the data set with descriptive variable names

names(Y_test_train)<-"activity"

names_temp<-gsub("\\(|\\)","",features$V2[cc] ) ## get rid of brackets in the names
names(X_test_train_select)<-names_temp;
names(subject_test_train)<-"subject"

## step 5: create a second, independent tidy data set with the
## average of each variable for each acivity and each subject

DT<-cbind(subject_test_train,Y_test_train,X_test_train_select)
DT_g<-group_by(DT,subject, activity)
DT_s<-summarise_each(DT_g,funs(mean))
write.table(DT_s,'Results.txt',row.name=FALSE)

