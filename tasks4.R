# Q4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#Read the data into R:
# NEI: National Emissions Inventory  (the data for years 1999,2002,2005,2008)
# SCC: Source Classification Code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Find the SCC codes associated with "coa"
# Both "Coal" and "Lignite" are listed in the "SCC.Level.Three" column
# of the Source_Classification_Code.rds file. Lignite is a soft from of coal. 

polluteCodeIndex <-  unique(full_join(grep("coal | lignite",SCC$SCC.Level.Three, ignore.case = TRUE),
grep("coal | lignite",SCC$SCC.Level.Four, ignore.case = TRUE)))
