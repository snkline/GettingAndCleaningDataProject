GettingAndCleaningDataProject
=============================

Class Project for Coursera Getting and Cleaning Data

The following steps are taken to tidy the data:
	 1. Pull in features.txt as a string vector: this will form the basis of the names() for the features in the dataset.	
	 2. Pull in the activity_labels as a data frame: this will be used for mapping activity codes.
	 3. Pull in subject_train.txt as a string vector.
	 4. Pull in y_train.txt as a string vector.
	 5. Pull in X_train.txt as a data frame
	 6. Assign features.txt vector to names() of X_train
	 7. Prepend X_train vector with activity labels based on y_train vector. Give column the name "Activity".
	 8. Prepend X_train vector with subject ids from the subject_train vector. Give the column the name "Subject_ID".
	 9. Repeat steps 3-8 for test data.
	10. Merge train and test data, excluding all *_train/test columns that are not means or std. deviations.
	11. Use dataset from step 10 to generate a second dataset with the following pseudo-schema:
		Subject_ID	|	Activity	|	Average Feature_1	|	Average Feature_2	|	Average Feature_3	|	Etc....
		----------------------------------------------------------------------------------------------------
		Where each Feature is either the mean or std. deviation measurements from dataset generated in step 10.
