setwd("/Users/ba25714/Getting-and-Cleaning-Data-Course-Project")

if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/UCI_DataSet.zip",method="curl")

unzip("data/UCI_DataSet.zip")