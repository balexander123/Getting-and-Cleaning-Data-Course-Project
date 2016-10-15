setwd("~/coursera/GettingCleaning/CourseProject")

DownloadData <- function() {
  if(!file.exists("data")){dir.create("data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/UCI_DataSet.zip",method="curl")
  unzip("data/UCI_DataSet.zip")
}

Setup <- function() {
  
  InstallRequire <- function(package) {
    install.packages(package)
    require(package,character.only=TRUE)
  }
  
  # Download data
  DownloadData()
  
  # Install required packages
  InstallRequire("dplyr")
}

MakeTidy1 <- function(dataRootDir = "UCI HAR Dataset") {

  MakePath <- function(file) {
    paste(dataRootDir,"/",file,sep="")
  }
  
  # Load files
  kX_test_txt <- MakePath("test/X_test.txt")
  kX_train_txt <- MakePath("train/X_train.txt")
  kFeatures_txt <- MakePath("features.txt")
  kActivity_labels_txt <- MakePath("activity_labels.txt")
  kTest_y_test_txt <- MakePath("test/y_test.txt")
  kTrain_y_train_txt <- MakePath("train/y_train.txt")
  kTest_subject_test_txt <- MakePath("test/subject_test.txt")
  kTrain_subject_train_txt <- MakePath("train/subject_train.txt")

  # Merge training and test sets
  testSet <- read.table(kX_test_txt)
  trainingSet <- read.table(kX_train_txt)
  allObservations <- dplyr::bind_rows(testSet,trainingSet)
  
  allObservations
  
  # Descriptive names for columns
  featureNames <- read.table(kFeatures_txt,stringsAsFactors=FALSE)[[2]]
  colnames(allObservations) <- featureNames
  # take only mean, std, or activityLabel columns
  allObservations <- allObservations[,grep("mean|std|activityLabel",featureNames)]
  
  obsNames = names(allObservations)
  obsNames <- gsub(pattern="^t",replacement="time",x=obsNames)
  obsNames <- gsub(pattern="^f",replacement="freq",x=obsNames)
  obsNames <- gsub(pattern="-?mean[(][)]-?",replacement="Mean",x=obsNames)
  obsNames <- gsub(pattern="-?std[()][)]-?",replacement="Std",x=obsNames)
  obsNames <- gsub(pattern="-?meanFreq[()][)]-?",replacement="MeanFreq",x=obsNames)
  obsNames <- gsub(pattern="BodyBody",replacement="Body",x=obsNames)
  names(allObservations) <- obsNames
  
  activityLabels <- read.table(kActivity_labels_txt,stringsAsFactors=FALSE)
  colnames(activityLabels) <- c("activityID","activityLabel")
  
  testActivities <- read.table(kTest_y_test_txt,stringsAsFactors=FALSE)
  trainingActivities <- read.table(kTrain_y_train_txt,stringsAsFactors=FALSE)
  allActivities <- dplyr::bind_rows(testActivities,trainingActivities)
  # Add activityID for joining
  colnames(allActivities)[1] <- "activityID"
  # Join by activityLabels
  activities <- dplyr::inner_join(allActivities,activityLabels,by="activityID")
  allObservations <- cbind(activity=activities[,"activityLabel"],allObservations)
  
  testSubjects <- read.table(kTest_subject_test_txt,stringsAsFactors=FALSE)
  trainingSubjects <- read.table(kTrain_subject_train_txt,stringsAsFactors=FALSE)
  allSubjects <- dplyr::bind_rows(testSubjects,trainingSubjects)
  colnames(allSubjects) <- "subject"
  
  allObservations <- cbind(allSubjects,allObservations)
  
  allObservations <- dplyr::arrange(allObservations,subject,activity)
  
  allObservations
}

MakeTidy2 <- function(inputData) {
  # go long, create a long dataset from a wide one
  molten <- reshape2::melt(inputData,id.vars= c("subject","activity"))
  # go wide, aggregating on subject + activity and applying mean function
  cast <- reshape2::dcast(molten, subject+activity ~ variable, fun.aggregate=mean)
  cast
}

SaveDataSets <- function() {
  tidy1 <- MakeTidy1()
  tidy2 <- MakeTidy2(tidy1)
  write.table(tidy1, file="tidy1.csv", row.name=FALSE)
  write.table(tidy2, file="tidy2.csv", row.name=FALSE)
}