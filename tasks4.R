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
# plot(coalData$Emissions) to see variations

#plot data

p4 <-ggplot(coalData,aes(year,Emissions)) +
  geom_point(aes(colour = SCC), size = 4, alpha = .3, show.legend = FALSE) +
  facet_wrap(facets = vars(type), scales = "free_y")+
  scale_x_continuous("Year",breaks = c(1999,2002,2005,2008),labels = years)+
  geom_smooth(method = "lm", show.legend = FALSE, colour = "blue")+
  labs(title = "PM2.5 emissions from coal and combustion processes in the US",
       subtitle = "POINT sources (such as factories) produce many more
       tons of PM2.5 than NONPOINT sources (such as agriculture)",
       caption = "POINT emissions have decreased. NonPOINT emission have 
       decreased as the outliers seem to have cleaned up.
       Lineary Model trend line shown in blue.")

png('plot4.png',width=480,height=480,units="px",bg = "transparent")
print(p4)
dev.off()

