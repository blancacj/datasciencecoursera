### File descriptions:
#Results.txt contains the tidy data set created in step 5 of the instructions.
#run_analysis.R is the script I created to performe my analysis
#code book lists all the variables and summaries I calculated

### explaination of the analysis code run_anlysis.R
#First, before you run the code,make sure that the current working directory is the directory where the data has been saved

#step 1: I used read.table() to read in all the inertial signal data sets, subject data sets(subject_test and subject_train), activities data sets(Y_test and Y_train), and the processed information data sets (X_train, and X_test).
 I used rbind() function to combine all the test and train data sets together and write them as text file in the current direcotory


#step 2: I extracted only the measurements on the mean and standard deviation foreach measurements.


#step 3: I used decriptive activity names to name the activities in the data set. activities which were originally labeled as "1" were changed to "walking".

#step 4: I labled the data set selected from the combined data set with descriptive variable names. Also I removed the brackets in the names of all the measured data sets

# step 5: I created a second, independent tidy data set with the average of each variable for each activity and each subject and saved it as Results.txt.
