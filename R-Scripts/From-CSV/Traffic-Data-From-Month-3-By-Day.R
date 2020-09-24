install.packages("dplyr")
library("dplyr")

# Reads in relevant CSVs.``
Month3 <- read.csv('032016-UniqueDevicesHourlyPerLocation.csv')
Month4 <- read.csv('042016-UniqueDevicesHourlyPerLocation.csv')

# Corrects Day and Hour for March.
Month3 <- transform(Month3, HourCorrected = ifelse(Hour >= 12, Hour - 12, Hour + 12))
Month3 <- transform(Month3, DayCorrected = ifelse(Hour >= 12, Day, Day - 1))
# Gives + 1 hour for March 13th after 1400 (11 hour difference).
Month3$HourCorrected[Month3$day==13 & Month3$hour >= 14] <-
  Month3$HourCorrected[Month3$day==13 & Month3$hour >= 14] + 1
# Corrects Day and Hour for April.
Month4 <- transform(Month4, HourCorrected = ifelse(Hour >= 11, Hour - 11, Hour + 13))
Month4 <- transform(Month4, DayCorrected = ifelse(Hour >= 11, Day, Day - 1))

# Removes Day 0 from Month 3 original dataframe, binds Day 0 from following month.
Month3 <- Month3[!(Month3$DayCorrected == 0),]
Month3 <- rbind(Month3,Month4[which(Month4$DayCorrected == 0), ])

# Changes DayCorrected == 0 to the last day of the Month.
Month3$DayCorrected[Month3$DayCorrected == 0] <- 31

# Write Month 3 to CSV files.
write.csv(Month3, file="032016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv")

# Can Clear the environment and restart from here if you would like to.
Month3 <- read.csv('032016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv')

# Delete non-essential columns.
Month3$X.1 <- NULL
Month3$X <- NULL
Month3$Day <- NULL
Month3$Hour <- NULL

# Creates sum of each hour for unique devices at each location.
TwentyFourHourSum <- Month3 %>% group_by(Reader.Identifier, Longitude, Latitude, DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))

# Create a dataframe for each day.
for (i in 1:31)
{
  # For days < 10.
  if (i < 10)
  {
    # Creates the name of the data frame, ie. 01, 02, etc.
    nam <- paste("Day0", i, sep = "")
    # Creates the dataframe.
    assign(nam, TwentyFourHourSum[TwentyFourHourSum$DayCorrected == i,])
  }
  # For days >= 10.
  else
  {
    # 0 is not needed to keep the dataframes in sequential order.
    nam <- paste("Day", i, sep = "")
    # Creates the dataframe.
    assign(nam, TwentyFourHourSum[TwentyFourHourSum$DayCorrected == i,])
  }
}

for (z in 1:2259)
{
  # Set the variable "i" to 1.
  i <- 1
  
  # Provide the intial values for the list to be created.
  # Hours keeps track of which hours the count is associated with for days when there are not 24 hours of data.
  hours <- paste(Day01$HourCorrected[i])
    
  # The count from the current hour.
  counts <- paste(Day01$Count[i])
  
  # Sets the current max for this row to the value (Used for normalizing data.).
  max <- as.integer(paste(Day01$Count[i]))
  
  # Checks to see if Day01Final has been created yet.
  if (exists('Day01Final'))
  {
    # Updates the dataframe to hold the final data.
    Day01Final[z,] <- Day01[i,c("Reader.Identifier","Longitude","Latitude")]
  }
  else
  {
    # Creates the dataframe to hold the final data.
    Day01Final <- Day01[i,c("Reader.Identifier","Longitude","Latitude")]
  }
  
  # Does this if columns have not yet been created.
  if ("Hours" %in% colnames(Day01Final))
  {
    #Do Nothing.
  }
  else
  {
    # Creates empty columns to receive data.
    Day01Final$Hours <- NA
    Day01Final$Counts <- NA
    Day01Final$Normalized <- NA
  }
  
  # Checks to see if the next row is for the same reader identifier as the current row.
  while (Day01$Reader.Identifier[i] == Day01$Reader.Identifier[i + 1])
  {
      # Hours keeps track of which hours the count is associated with for days when there are not 24 hours of data.
      hours <- paste(hours, Day01$HourCorrected[i + 1])
      # The count from the current hour.
      counts <- paste(counts, Day01$Count[i + 1], sep=",")
      # Checks to see if the value for this day becomes the new max value for the daily range.
      if(max < as.integer(Day01$Count[i + 1]))
      {
        max <- as.integer(Day01$Count[i + 1])
      }
      
      # Deletes current row.
      Day01 <- Day01[-1,]
  }

  
  # Converts string lists to lists of integers.
  counts <- as.integer(unlist(strsplit(counts,",")))
  hours <- as.integer(unlist(strsplit(hours," ")))  
  # Normalizes the values.
  normalized <- counts/max
  # Resets the max value to 0.
  max <- 0

  # Creates a variables or empties them to be filled later.
  finalhours <- as.integer(NULL)
  finalcounts <- as.integer(NULL)
  finalnormalized <- as.double(NULL)
  
  # This for loop fills in 0's for missing data.
  for (i in 1:24)
  {
    if (is.na(hours[i]) == FALSE)
    {
      if (hours[i] == i - 1)
      {
      finalhours <- paste(finalhours,hours[i])
      finalcounts <- paste(finalcounts,counts[i])
      finalnormalized <- paste(finalnormalized,normalized[i])
      }
      else
      {
      finalhours <- paste(finalhours,i-1)
      finalcounts <- paste(0,finalcounts)
      finalnormalized <- paste(0,finalnormalized)
      }
    }
    else
    {
      finalhours <- paste(finalhours,i-1)
      finalcounts <- paste(finalcounts,0)
      finalnormalized <- paste(finalnormalized,0)
    }
  }
  
  # Converts to an integer list.
  finalhours <- as.integer(unlist(strsplit(finalhours," ")))
  # Removes NA value
  finalhours <- finalhours[!is.na(finalhours)]
  # Converts to an integer list.
  finalcounts <- as.integer(unlist(strsplit(finalcounts," ")))
  # Removes NA value
  finalcounts <- finalcounts[!is.na(finalcounts)]
  # Converts to an double list.
  finalnormalized <- as.double(unlist(strsplit(finalnormalized," ")))
  # Removes NA value
  finalnormalized <- finalnormalized[!is.na(finalnormalized)]
  
  
  # Pastes the values into the appropriate columns.
  Day01Final$Hours[z] <- paste0("[",paste(as.list(finalhours),collapse=","),"]")
  Day01Final$Counts[z] <- paste0("[",paste(as.list(finalcounts),collapse=","),"]")
  Day01Final$Normalized[z] <- paste0("[",paste(as.list(finalnormalized),collapse=","),"]")
  
  # Deletes Current Row.
  Day01 <- Day01[-1,]
  
}

# Write Day 01 to CSV file.
write.table(Day01Final, "01MAR2016-UniqueDevicesHourlyPerLocation_CorrectTimes.txt", sep="\t", quote = FALSE)

# Create a backup, and use backup for Day01
Day01Backup <- Day01
Day01 <- Day01Backup
