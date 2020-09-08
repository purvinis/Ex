#The overall goal of this assignment is to explore the National Emissions 
#Inventory database and see what it say about fine particulate matter 
#pollution in the United states over the 10-year period 1999–2008.

#Read the data into R:
# NEI: National Emmissions Inventory  (the data for years 1999,2002,2005,2008)
# SCC: Source Classification Code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Q1. 
# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the 
# total PM2.5 emission from all sources for each of the years
# 1999, 2002, 2005, and 2008.

emmissionTot <-NEI$Emissions
print(mean(is.na(emmissionTot)))   #make sure there are no NAs
emByYr <- sapply(split(emmissionTot,NEI$year), sum)
years <- unique(NEI$year)

png(filename = "plot1.png")

bp <- barplot(emByYr, col = rgb( .5,0,.5,.2),
     xlab = "Year",
     ylab = "tons",
     main = "Total PM2.5 emission in the U.S. \n from all sources by year",
     sub = "Bar plot showing total PM2.5 decreased from 1999 to 2008.")
text(bp,emByYr*0.9,labels = round(emByYr,digits = 0))

dev.off()

# Q2.
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering 
# this question.

baltimore <- subset(NEI,NEI$fips=="24510")
emissionsBalt <-baltimore$Emissions
print(mean(is.na(emmissionTot)))   #make sure there are no NAs
emByYrBalt <- sapply(split(emissionsBalt,baltimore$year), sum)
years <- unique(baltimore$year)

png(filename = "plot2.png")

bp <- barplot(emByYrBalt, col = rgb( 0,0.5,0.5,0.2),
              xlab = "Year",
              ylab = "tons",
              main = "Total PM2.5 emission in Baltimore \n from all sources by year",
              sub = "Total PM2.5 in Baltimore varied from 1999 to 2008.")
text(bp,emByYrBalt*0.9,labels = round(emByYrBalt,digits = 0))

dev.off()

#Q3.
# Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from
# 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.
