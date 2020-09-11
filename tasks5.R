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
  select(Emissions,year)

motorVehicleData <-arrange(motorVehicleData,year)  #arrange by year, lowest to highest
av1999 <- motorVehicleData %>% filter(year == "1999") %>%
  select(Emissions)

ggplot(motorVehicleData, aes(x = year,y = Emissions))+
  geom_point()+
  geom_smooth(method = "lm", color = rgb(.5,0,.5))

