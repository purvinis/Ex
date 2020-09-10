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

yearSum <- function(t,y){
  s <- baltimore %>% subset(year == y) %>%
    subset(type == t) %>% select(Emissions) %>% sum
  return(as.numeric(s)) }

sumData <- data.frame()
for(t in types)
  {
  for (y in years)
  {
    arow <- c(t,y,yearSum(t,y))
    sumData <-rbind(sumData,arow)
  }
}
colnames(sumData) <- c("type","year","Emissions")
sumData$type <- transform(sumData$type,)

ggplot(sumData, aes(year, Emissions)) +
  geom_col(color = "orange",alpha = .4) +
  facet_wrap(facets = vars(type), nrow = 2,scales = "free_y")

ggplot(baltimore, aes(year, Emissions)) +
  geom_point(color = "orange", size = 3, alpha = .4) +
  geom_point(data = sumData,color = "green", alpha = 0.1) +
  facet_wrap(facets = vars(type), nrow = 2) +
  scale_x_continuous(limits=c(0, 1600), breaks=c(0, 400, 800, 1200,1600))


  geom_smooth(method = "lm")
  


