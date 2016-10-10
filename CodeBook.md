# Code Book
## Variables
## Data Sources
### Download Location
### File Structure
![InputFiles logo](files.png)
### Data Model
#### Entity Relationships
#### Data Dictionary
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

Use dplyr::bind_rows to combine X_train.txt and X_test.txt files

```R
# Merge training and test sets
testSet <- read.table(kX_test_txt)
trainingSet <- read.table(kX_train_txt)
allObservations <- dplyr::bind_rows(testSet,trainingSet)
```
### Extraction
### Meaningful Names
## Tidy_1.csv
## Reshaping Data
### Tidy_2.csv
## End Notes
