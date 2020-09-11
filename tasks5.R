# Q5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Interested in these EISectors from SCC file:
#  unique(SCC$EI.Sector)
# [21] Mobile - On-Road Gasoline Light Duty Vehicles     
# [22] Mobile - On-Road Gasoline Heavy Duty Vehicles     
# [23] Mobile - On-Road Diesel Light Duty Vehicles       
# [24] Mobile - On-Road Diesel Heavy Duty Vehicles

#Read the data into R:
# NEI: National Emissions Inventory  (the data for years 1999,2002,2005,2008)
# SCC: Source Classification Code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI,NEI$fips=="24510")

#Get SCC codes associated with Mobile
mobileCodeIndex <- grep("Mobile",SCC$EI.Sector)
mobileSCC <- as.character(SCC$SCC[mobileCodeIndex])

#Find codes in the Baltimore data and extract Emissions:
motorVehicleData <- baltimore %>% filter(SCC %in% mobileSCC)%>%
  select(year,Emissions)
years <- unique(motorVehicleData$year)

# find averages per year, because data values are too widely spred to see trends:
motorVehicleData <-arrange(motorVehicleData,year)  #arrange by year, lowest to highest
av1999 <- motorVehicleData %>% filter(year == "1999") %>%
  select(Emissions) %>% sapply(mean)
av2002 <- motorVehicleData %>% filter(year == "2002") %>%
  select(Emissions) %>% sapply(mean)
av2005 <- motorVehicleData %>% filter(year == "2005") %>%
  select(Emissions) %>% sapply(mean)
av2008 <- motorVehicleData %>% filter(year == "2008") %>%
  select(Emissions) %>% sapply(mean)
averages <- c(av1999,av2002,av2005,av2008)

# make plots
png(filename = "plot5.png")
p5 <-barplot(averages, col = rgb( .1,.5,.0,.2),
        names.arg = c("1999","2002",2005,"2008"),
        xlab = "Year",
        ylab = "Emissions, tons",
        main = "AVERAGE PM2.5 emissions from motor vehicles \n in Baltimore for specific years.",
        sub = "Bar plot shows average PM2.5 per year does not linearly decline.")
text(p5,averages*0.9,labels = round(averages,digits = 2))
dev.off()


