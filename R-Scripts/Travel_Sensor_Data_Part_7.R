install.packages('readr')
install.packages("dplyr")

library(readr)
library(dplyr)

# Reads in CSV created by Part 7 as a dataframe.
TravelSensorReadings <- read.csv(file="AggregateTravelSensorReadings.csv", colClasses=c(NULL, NA, NA, NA, NA, NA))

# Write CSV in R
write.csv(TravelSensorReadings %>%
            group_by(Reader.Identifier) %>%
            summarize(Count = sum(Count)), file = "JAN_to_Aug_Count_by_Reader.csv")

write.csv(TravelSensorReadings %>%
  group_by(Hour) %>%
  summarize(Count = sum(Count)), file = "JAN_to_Aug_Count_by_Hour.csv")
