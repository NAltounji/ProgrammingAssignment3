Steps of the assignment  

The steps are:  

1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

The R script  

The R script which is named as "run_analysis.R" will do these steps will explanations for most important commands.

Variables:

* url1: the zip file url.  
* features: gives names for variables of **Xtest** and **Xtrain** datasets.  
* activitylabels: the activity names and we used it to name the activites in **meansddata** dataset.  
* Xtest, Ytest, subtest, Xtrain, Ytrain, subtrain: contains the data, activity ids, and subject ids.  
* fulldata: is a dataset created by merging previous vars.  
* meansddata: extracted data for mean and sd only.  
* avgdata: a dataset contain means for each variable in the **meansddata** dataset, and it saved as .txt file.  
