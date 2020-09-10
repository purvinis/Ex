#Q3.
# Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from
# 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

#Read the data into R:
# NEI: National Emmissions Inventory  (the data for years 1999,2002,2005,2008)
# SCC: Source Classification Code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI,NEI$fips=="24510")
years <- unique(baltimore$year)
types <- unique(baltimore$type)

baltimore <- baltimore %>% select(type,year,Emissions)

#function to sum the emissions by year and type
yearSum <- function(t,y){
  s <- baltimore %>% subset(year == y) %>%
    subset(type == t) %>% select(Emissions) %>% sum %>% as.numeric
  return(s) }

#find the emission totals by year and type
sumData <- data.frame(stringsAsFactors = FALSE)
for(t in types)
  {
  for (y in years)
  {
    arow <- c(t,as.integer(y),yearSum(t,y))
    sumData <-rbind(sumData,arow)
  }
}
colnames(sumData) <- c("type","year","Emissions")
sumData$year <-as.integer(sumData$year)
sumData$Emissions <- as.integer(sumData$Emissions)

#make scatter plot of Emissions with barchart of totals overlayed:
p3 <- ggplot(baltimore, aes(year, Emissions)) +
  geom_point(color = "orange", size = 3, alpha = .7) +
  geom_col(data = sumData,color = "green", alpha = 0.1, width = 1.1) +
  facet_wrap(facets = vars(type), nrow = 2,scales = "free_y")+
  scale_x_continuous("Year",breaks = c(1999,2002,2005,2008),labels = years)+
  labs(title = "PM2.5 emissions in Baltimore by year and type",
       subtitle = "Non-road, nonpoint, on-road sensors show net decrease in PM2.5.",
       caption = "Scatter plot data is from individual sensors.Green bars
       indicate year totals, in tons.")

png('plot3.png',width=480,height=480,units="px",bg = "transparent")
print(p3)
dev.off()



  


