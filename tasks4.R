# Q4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#Read the data into R:
# NEI: National Emissions Inventory  (the data for years 1999,2002,2005,2008)
# SCC: Source Classification Code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Find the SCC codes associated with "coal"
# Find "coal" or "Coal" in EI.Sector and C/combustion in SCC.Level.One
# of the Source_Classification_Code.rds file. Lignite is a soft from of coal.
# Exploring grep of different columns and terms ultimately results in 99 matches.

polluteCodeIndex <-  intersect(grep("[Cc]oal",SCC$EI.Sector),
grep("[Cc]ombustion",SCC$SCC.Level.One))

polluteCodes <- as.character(SCC$SCC[polluteCodeIndex])

#Subset the NEI data for coal-combustion
coalData <- NEI %>% filter(SCC %in% polluteCodes)%>%
  select(SCC, Emissions,type,year)

#Summrizing or scatter plotting "Emissions" shows HUGE variation. Data shows a large variation between
# POINT and NONPOINT Emissions (the only two types present in the coal-combustion data)
# Nonpoint source (NPS) areas of focus are driven by particular land uses, such as agriculture
# Point source : any single identifiable source of pollution from which pollutants are discharged, 
# such as a pipe, ditch, ship or factory smokestack.”
plot(coalData$Emissions)

#plot data
png(filename = "plot4.png")

ggplot(coalData,aes(year,Emissions)) +
  geom_density(aes(y=Emissions),color = "red", alpha = .3) +
  facet_wrap(facets = vars(type), scales = "fixed")+
  scale_x_continuous("Year",breaks = c(1999,2002,2005,2008),labels = years)+
  labs(title = "PM2.5 emissions in Baltimore by year and type",
       subtitle = "Non-road, nonpoint, on-road sensors show net decrease in PM2.5.",
       caption = "Scatter plot data is from individual sensors.Green bars
       indicate year totals, in tons.")



dev.off()