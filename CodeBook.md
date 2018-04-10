
# ++++++++++++++Variable Names+++++++++++++
Subject <- Subject ID under study
Activity <- Activity type for which readings are taken

# ++++++++++++++Transformations+++++++++++++
merged X_train and X_test to get "features"data
assigned "features.txt" as labels to "features" data 
merged y_train and y_test to get "activities" data
merged subject_train and subject_test to get "subject" data
subset of features data obtained by filtering features that contain "mean" or "standard deviation"


# ++++++++variables renamed++++++++++++
#prefix t is replaced by time
#Acc is replaced by Accelerometer
#Gyro is replaced by Gyroscope
#prefix f is replaced by frequency
#Mag is replaced by Magnitude
#BodyBody is replaced by Body
