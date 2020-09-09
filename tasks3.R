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

ggplot(baltimore, aes(year, Emissions)) +
  geom_point(color = "orange", size = 3, alpha = .4) +
  facet_wrap(facets = vars(type), nrow = 2, scales = "free_y") +
  geom_smooth(method = "lm")
  
  
  
  
test <- baltimore %>% subset(type == types[1]) %>%
  subset(year==years[1]) %>% select(Emissions) %>% sum

