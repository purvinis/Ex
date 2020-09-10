# Q2.
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering 
# this question.

#Read the data into R:
# NEI: National Emmissions Inventory  (the data for years 1999,2002,2005,2008)
# SCC: Source Classification Code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI,NEI$fips=="24510")
emissionsBalt <-baltimore$Emissions
print(mean(is.na(emissionsBalt)))   #make sure there are no NAs
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
