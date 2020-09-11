# Q6
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037"),
# Which city has seen greater changes over time in motor vehicle emissions?

#Read the data into R:
# NEI: National Emissions Inventory  (the data for years 1999,2002,2005,2008)
# SCC: Source Classification Code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI,NEI$fips=="24510")
losAng <-subset(NEI,NEI$fips=="06037")

#Get SCC codes associated with Mobile identifying vehicle sources
mobileCodeIndex <- grep("Mobile",SCC$EI.Sector)
mobileSCC <- as.character(SCC$SCC[mobileCodeIndex])

#Find codes in the Baltimore and LosAngeles data and extract Emissions:
motorVehicleDataBalt <- baltimore %>% filter(SCC %in% mobileSCC)%>%
  select(year,Emissions)
motorVehicleDataLA <- losAng %>% filter(SCC %in% mobileSCC)%>%
  select(year,Emissions)
years <- unique(motorVehicleDataLA$year)

# "Greater changes over time" means looking at percent change (by year?)
# (current_year_total- 1999_total)/(1999_total)  --> percent change

# find total Emissions per year:
tot1999Balt <- motorVehicleDataBalt %>% filter(year == "1999") %>%
  select(Emissions) %>% sapply(sum)
tot2002Balt <- motorVehicleDataBalt %>% filter(year == "2002") %>%
  select(Emissions) %>% sapply(sum)
tot2005Balt <- motorVehicleDataBalt %>% filter(year == "2005") %>%
  select(Emissions) %>% sapply(sum)
tot2008Balt <- motorVehicleDataBalt %>% filter(year == "2008") %>%
  select(Emissions) %>% sapply(sum)
totBalt <- c(tot1999Balt,tot2002Balt,tot2005Balt,tot2008Balt)

tot1999LA <- motorVehicleDataLA %>% filter(year == "1999") %>%
  select(Emissions) %>% sapply(sum)
tot2002LA <- motorVehicleDataLA %>% filter(year == "2002") %>%
  select(Emissions) %>% sapply(sum)
tot2005LA <- motorVehicleDataLA %>% filter(year == "2005") %>%
  select(Emissions) %>% sapply(sum)
tot2008LA <- motorVehicleDataLA %>% filter(year == "2008") %>%
  select(Emissions) %>% sapply(sum)
totLA <- c(tot1999LA,tot2002LA,tot2005LA,tot2008LA)

# Function to calculate percent change from 1999 to 2008
percentChange <- function(eTot){
  p <- NULL
  for(i in 1:4){
  p[i] <- (eTot[i]-eTot[1])/eTot[1] * 100
  }
  p
}

# Put the percent changes into one dataframe for plotting
LAvsBaltChange <-as.data.frame(cbind(year = years,Baltimore = percentChange(totBalt),
                       LosAngeles = percentChange(totLA)))

#plot
p6 <-ggplot(LAvsBaltChange, aes(year)) + 
  geom_col(aes(y = Baltimore, fill = "Baltimore"),width = 1.2,show.legend = TRUE) + 
  geom_col(aes(y = LosAngeles, fill = "LosAngeles"),width = 1.2,show.legend = TRUE)+
  geom_line(aes(y = Baltimore))+
  geom_line(aes(y = LosAngeles))+
  scale_x_continuous("Year",breaks = c(1999,2002,2005,2008),labels = years)+
  scale_fill_manual(values=c("blue","red"), name="Location")+
  geom_line(y = 0, lwd = 2)+
  labs(title = "Percent change in vehicle emissions, 1999 to 2008",
       subtitle = "Baltimore has the greatest percent changes since 1999.
       Between 1999 and 2002, Baltimore showed a
       56% decrease in emissions.",
       caption = "Baltimore shows decreases in emissions compared to 1999,
       while LosAngeles shows increases.",
       y = "Percent change")+
  theme(legend.text=element_text(size=14), legend.title=element_text(""))

png('plot6.png',width=480,height=480,units="px",bg = "transparent")
print(p6)
dev.off()


