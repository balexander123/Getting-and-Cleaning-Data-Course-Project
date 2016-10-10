setwd("/Users/ba25714/Getting-and-Cleaning-Data-Course-Project")

install.packages("plyr")
require("plyr",character.only=TRUE) 

MakeTidy1 <- function(dataRootDir = "UCI HAR Dataset") {
  
  # utility function
  FilePath <- function(file) {
    paste(dataRootDir,"/",file,sep="")
  }
  
  MakePath <- function(file) {
    paste(dataRootDir,"/",file,sep="")
  }

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
  allObservations <- rbind(testSet,trainingSet)
  
  allObservations
  
}