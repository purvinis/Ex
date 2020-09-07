#The overall goal of this assignment is to explore the National Emissions 
#Inventory database and see what it say about fine particulate matter 
#pollution in the United states over the 10-year period 1999–2008.

#Read the data into R:
# NEI: National Emmissions Inventory  (the data)
# SCC: Source Classification Code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Q1. 
# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the 
# total PM2.5 emission from all sources for each of the years
# 1999, 2002, 2005, and 2008.