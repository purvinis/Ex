#######################################################################
## Programmer: GP
## Date: 9/7/2020
## Project: Ex_Data_CourseProject2.RProj
## Description: Exploratory Data Week 4 Assignment
## This file extracts the zipped data, and loads libraries
#######################################################################

# Load needed packages and download the data
library(dplyr)
library(tidyr)
library(lubridate)
library(data.table)
library(ggplot2)

# dataset: Get zipped file from course website and put in current director
# Then unzip it

zipfile <- dir()[grep("zip",dir())]             #get the zip file name
unzip(zipfile)                            #unzip in current directory

# Two files will result with an *.rds extension
# Use dir() to see the names


