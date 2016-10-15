# Code Book
## Variables
## Data Sources
### Download Location
### Data Files And Relationships
After exploding the compressed data file UCI_DataSet.zip, the files are arranged in the following file hierarchy:

```bash
$ tree
.
├── UCI\ HAR\ Dataset
│   ├── README.txt
│   ├── activity_labels.txt
│   ├── features.txt
│   ├── features_info.txt
│   ├── test
│   │   ├── Inertial\ Signals
│   │   │   ├── body_acc_x_test.txt
│   │   │   ├── body_acc_y_test.txt
│   │   │   ├── body_acc_z_test.txt
│   │   │   ├── body_gyro_x_test.txt
│   │   │   ├── body_gyro_y_test.txt
│   │   │   ├── body_gyro_z_test.txt
│   │   │   ├── total_acc_x_test.txt
│   │   │   ├── total_acc_y_test.txt
│   │   │   └── total_acc_z_test.txt
│   │   ├── X_test.txt
│   │   ├── subject_test.txt
│   │   └── y_test.txt
│   └── train
│       ├── Inertial\ Signals
│       │   ├── body_acc_x_train.txt
│       │   ├── body_acc_y_train.txt
│       │   ├── body_acc_z_train.txt
│       │   ├── body_gyro_x_train.txt
│       │   ├── body_gyro_y_train.txt
│       │   ├── body_gyro_z_train.txt
│       │   ├── total_acc_x_train.txt
│       │   ├── total_acc_y_train.txt
│       │   └── total_acc_z_train.txt
│       ├── X_train.txt
│       ├── subject_train.txt
│       └── y_train.txt
```

Of these files, the following will be used to construct a tidy data set:

* features.txt - column names for X_train.txt and X_test.txt observation files
* X_train.txt - observation data for training subjects
* X_test.txt - observation data for test subjects
* subject_train.txt - subject IDs for training observations
* Y_train.txt - activity IDs for training observations
* subject_test.txt - subject IDs for test observations
* Y_test.txt - activity IDs for test observations


The relationships between these files is shown in Figure 1.

![InputFiles logo](files.png)
<center><a name="myfootnote1">[1]</a>: Figure 1- File structure and relationships</center>
### Tidy Data
The desired tidy data set will have one observation per row from the combined test and training observations.  Columns will constist of the following 81 variables:

```R
> variable.names(tidy1)
 [1] "subject"                     "activity"                   
 [3] "timeBodyAccMeanX"            "timeBodyAccMeanY"           
 [5] "timeBodyAccMeanZ"            "timeBodyAccStdX"            
 [7] "timeBodyAccStdY"             "timeBodyAccStdZ"            
 [9] "timeGravityAccMeanX"         "timeGravityAccMeanY"        
[11] "timeGravityAccMeanZ"         "timeGravityAccStdX"         
[13] "timeGravityAccStdY"          "timeGravityAccStdZ"         
[15] "timeBodyAccJerkMeanX"        "timeBodyAccJerkMeanY"       
[17] "timeBodyAccJerkMeanZ"        "timeBodyAccJerkStdX"        
[19] "timeBodyAccJerkStdY"         "timeBodyAccJerkStdZ"        
[21] "timeBodyGyroMeanX"           "timeBodyGyroMeanY"          
[23] "timeBodyGyroMeanZ"           "timeBodyGyroStdX"           
[25] "timeBodyGyroStdY"            "timeBodyGyroStdZ"           
[27] "timeBodyGyroJerkMeanX"       "timeBodyGyroJerkMeanY"      
[29] "timeBodyGyroJerkMeanZ"       "timeBodyGyroJerkStdX"       
[31] "timeBodyGyroJerkStdY"        "timeBodyGyroJerkStdZ"       
[33] "timeBodyAccMagMean"          "timeBodyAccMagStd"          
[35] "timeGravityAccMagMean"       "timeGravityAccMagStd"       
[37] "timeBodyAccJerkMagMean"      "timeBodyAccJerkMagStd"      
[39] "timeBodyGyroMagMean"         "timeBodyGyroMagStd"         
[41] "timeBodyGyroJerkMagMean"     "timeBodyGyroJerkMagStd"     
[43] "freqBodyAccMeanX"            "freqBodyAccMeanY"           
[45] "freqBodyAccMeanZ"            "freqBodyAccStdX"            
[47] "freqBodyAccStdY"             "freqBodyAccStdZ"            
[49] "freqBodyAccMeanFreqX"        "freqBodyAccMeanFreqY"       
[51] "freqBodyAccMeanFreqZ"        "freqBodyAccJerkMeanX"       
[53] "freqBodyAccJerkMeanY"        "freqBodyAccJerkMeanZ"       
[55] "freqBodyAccJerkStdX"         "freqBodyAccJerkStdY"        
[57] "freqBodyAccJerkStdZ"         "freqBodyAccJerkMeanFreqX"   
[59] "freqBodyAccJerkMeanFreqY"    "freqBodyAccJerkMeanFreqZ"   
[61] "freqBodyGyroMeanX"           "freqBodyGyroMeanY"          
[63] "freqBodyGyroMeanZ"           "freqBodyGyroStdX"           
[65] "freqBodyGyroStdY"            "freqBodyGyroStdZ"           
[67] "freqBodyGyroMeanFreqX"       "freqBodyGyroMeanFreqY"      
[69] "freqBodyGyroMeanFreqZ"       "freqBodyAccMagMean"         
[71] "freqBodyAccMagStd"           "freqBodyAccMagMeanFreq"     
[73] "freqBodyAccJerkMagMean"      "freqBodyAccJerkMagStd"      
[75] "freqBodyAccJerkMagMeanFreq"  "freqBodyGyroMagMean"        
[77] "freqBodyGyroMagStd"          "freqBodyGyroMagMeanFreq"    
[79] "freqBodyGyroJerkMagMean"     "freqBodyGyroJerkMagStd"     
[81] "freqBodyGyroJerkMagMeanFreq"
```

 
## Tidy Steps
### Utility functions
```R
   MakePath <- function(file) {
     paste(dataRootDir,"/",file,sep="")
   }
  
   InstallRequire <- function(package) {
     install.packages(package)
     require(package,character.only=TRUE)
 }
```
### Download Data
```R
  if(!file.exists("data")){dir.create("data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/UCI_DataSet.zip",method="curl")
  unzip("data/UCI_DataSet.zip")
```

### Install required packages
```R
  InstallRequire("dplyr")
```

### Load files
```R
  kX_test_txt <- MakePath("test/X_test.txt")
  kX_train_txt <- MakePath("train/X_train.txt")
  kFeatures_txt <- MakePath("features.txt")
  kActivity_labels_txt <- MakePath("activity_labels.txt")
  kTest_y_test_txt <- MakePath("test/y_test.txt")
  kTrain_y_train_txt <- MakePath("train/y_train.txt")
  kTest_subject_test_txt <- MakePath("test/subject_test.txt")
  kTrain_subject_train_txt <- MakePath("train/subject_train.txt")
```

### Merge training and test sets

Use dplyr::bind\_rows to combine X\_train.txt and X\_test.txt files

```R
  # Merge training and test sets
  testSet <- read.table(kX_test_txt)
  trainingSet <- read.table(kX_train_txt)
  allObservations <- dplyr::bind_rows(testSet,trainingSet)
```
### Meaningful Names
```R
  # Descriptive names for columns
  featureNames <- read.table(kFeatures_txt,stringsAsFactors=FALSE)[[2]]
  colnames(allObservations) <- featureNames
```

### Extraction
```R
  # take only mean, std, or activityLabel columns
  allObservations <- allObservations[,grep("mean|std|activityLabel",featureNames)]
```
### Conform to Tidy Naming Conventions
```R
  obsNames = names(allObservations)
  obsNames <- gsub(pattern="^t",replacement="time",x=obsNames)
  obsNames <- gsub(pattern="^f",replacement="freq",x=obsNames)
  obsNames <- gsub(pattern="-?mean[(][)]-?",replacement="Mean",x=obsNames)
  obsNames <- gsub(pattern="-?std[()][)]-?",replacement="Std",x=obsNames)
  obsNames <- gsub(pattern="-?meanFreq[()][)]-?",replacement="MeanFreq",x=obsNames)
  obsNames <- gsub(pattern="BodyBody",replacement="Body",x=obsNames)
  names(allObservations) <- obsNames
```
### Setting Column Names
```R
  activityLabels <- read.table(kActivity_labels_txt,stringsAsFactors=FALSE)
  colnames(activityLabels) <- c("activityID","activityLabel")
  
  testActivities <- read.table(kTest_y_test_txt,stringsAsFactors=FALSE)
  trainingActivities <- read.table(kTrain_y_train_txt,stringsAsFactors=FALSE)
  allActivities <- dplyr::bind_rows(testActivities,trainingActivities)
  # Add activityID for joining
  colnames(allActivities)[1] <- "activityID"
```
### Joining
```R
  # Join by activityLabels
  activities <- dplyr::inner_join(allActivities,activityLabels,by="activityID")
  allObservations <- cbind(activity=activities[,"activityLabel"],allObservations)
```
### Combine Subjects
```R
  testSubjects <- read.table(kTest_subject_test_txt,stringsAsFactors=FALSE)
  trainingSubjects <- read.table(kTrain_subject_train_txt,stringsAsFactors=FALSE)
  allSubjects <- dplyr::bind_rows(testSubjects,trainingSubjects)
  colnames(allSubjects) <- "subject"
```
### Combine All Observations
```R
  allObservations <- cbind(allSubjects,allObservations)
```

### Sort Observations
```R
  allObservations <- dplyr::arrange(allObservations,subject,activity)
```

### Return The Tidy Data
```R
  allObservations
```
## Make Tidy2
### Reshaping Data with reshape2 Melt and Cast
```R
MakeTidy2 <- function(inputData) {
  # go long, create a long dataset from a wide one
  molten <- reshape2::melt(inputData,id.vars= c("subject","activity"))
  # go wide, aggregating on subject + activity and applying mean function
  cast <- reshape2::dcast(molten, subject+activity ~ variable, fun.aggregate=mean)
  cast
}
```
## Make The CSVs
```R
SaveDataSets <- function() {
  tidy1 <- MakeTidy1()
  tidy2 <- MakeTidy2(tidy1)
  write.csv(tidy1,file="tidy1.csv")
  write.csv(tidy2,file="tidy2.csv")
}
```

## End Notes
<sup>[1](#myfootnote1) David Hood, Community TA <a>https://class.coursera.org/getdata-008/forum/thread?thread_id=24</a></sup>