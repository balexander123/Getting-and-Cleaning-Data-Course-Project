setwd("/Users/ba25714/Getting-and-Cleaning-Data-Course-Project")

DownloadData <- function() {
  if(!file.exists("data")){dir.create("data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/UCI_DataSet.zip",method="curl")
  unzip("data/UCI_DataSet.zip")
}

MakeTidy1 <- function(dataRootDir = "UCI HAR Dataset") {
  
  # Utility functions
  MakePath <- function(file) {
    paste(dataRootDir,"/",file,sep="")
  }
  
  InstallRequire <- function(package) {
    install.packages(package)
    require(package,character.only=TRUE)
  }
  
  # Download data
  DownloadData()
  
  # Install required packages
  InstallRequire("dplyr")

  # Load files
  kX_test_txt <- MakePath("test/X_test.txt")
  kX_train_txt <- MakePath("train/X_train.txt")
  kFeatures_txt <- MakePath("features.txt")
  kActivity_labels_txt <- MakePath("activity_labels.txt")
  kTest_y_test_txt <- MakePath("test/y_test.txt")
  kTrain_y_train_txt <- MakePath("train/y_train.txt")
  kTest_subject_test_txt <- MakePath("test/subject_test.txt")
  kTrain_subject_train_txt <- MakePath("train/subject_train.txt")

  #merge training and test sets
  testSet <- read.table(kX_test_txt)
  trainingSet <- read.table(kX_train_txt)
  allObservations <- dplyr::bind_rows(testSet,trainingSet)
  
  allObservations
}