# Getting and Cleaning Data
## Course Project
### Introduction
Project details can be found here: <a>https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project</a>

### Description
Everything to download, transform and export tidy data sets is contained in <pre>run_analysis.R</pre>
### run_analysis.R
Within run_analysis.R there are 5 functions :

* Setup
* DownloadData
* MakeTidy1
* MakeTidy2
* SaveDataSets
 
#### Setup

Should be run once when you start your R analysis session.  I used R Studio to do this project.  I trust dear reader you know how to set your working path, load source code, etc.

Setup will install + load required packages, download the data and uncompress to the file system.

#### Download Data

DownloadData is called by Setup.  You can call DownloadData after setup if you need to refresh the raw data.

#### MakeTidy1

MakeTidy1 does the bulk of the work for this project.  It reads the raw data files, combines them, adds meaninful and consistent naming of variables.

The best details for MakeTidy1 can be found within the code book: <a>https://github.com/balexander123/Getting-and-Cleaning-Data-Course-Project/blob/master/CodeBook.md</a>

#### MakeTidy2

MakeTidy2 takes the output of MakeTidy1 and reshapes by subject + activity to compute means on observations.

More about MakeTidy2 can be found within the code book: <a>https://github.com/balexander123/Getting-and-Cleaning-Data-Course-Project/blob/master/CodeBook.md</a>

#### Save Data

SaveData saves both tidy1 and tidy2 data sets as CSV files.




