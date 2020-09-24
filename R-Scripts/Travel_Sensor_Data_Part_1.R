# Install the necessary packages.
install.packages("RSocrata")
install.packages("lubridate")
install.packages("plyr")
install.packages("dplyr")

# Loads the package library.
library("RSocrata")
library("lubridate")
library("plyr")
library("dplyr")

# Creates an empty dataframe to aggregate analyzed data to.
HourlySummary <- setNames(data.frame(matrix(ncol = 6, nrow = 0)), c("reader_identifier", "number_of_distinct_orders", "year", "month", "day", "hour"))

# Set this value to the number of lines you would like downloaded during each interval.
segment <- as.integer(2500000)
limit <- segment

# Starts timer to time the download.
start_time <- Sys.time()
# Uses the API to read in the data from data.austintexas.gove.
TravelSensorReadings <- read.socrata(
  paste("https://data.austintexas.gov/resource/2afc-qswz.json?$order=field_device_read_time ASC&$limit=",
        paste(limit)), app_token = "YOUR_APP_TOKEN_HERE")
# Ends timer and reports download time.
end_time <- Sys.time()
end_time - start_time

# Extracts the Year (4-digit), Month (2-digit), Day (2-digit), and the Hour (2-digit).
TravelSensorReadings$Year <- format(as.POSIXct(TravelSensorReadings$field_device_read_time), "%Y")
TravelSensorReadings$Month <- format(as.POSIXct(TravelSensorReadings$field_device_read_time), "%m")
TravelSensorReadings$Day <- format(as.POSIXct(TravelSensorReadings$field_device_read_time), "%d")
TravelSensorReadings$Hour <- format(as.POSIXct(TravelSensorReadings$field_device_read_time, format="%Y-%m-%d %H:%M:%S"), format="%H")

# The rows are downloaded in ascending order by datetime already, these variables may be used to determine which hour needs to be aggregated currently.
analysishour <- head(TravelSensorReadings$Hour,1)
analysisday <- head(TravelSensorReadings$Day,1)
analysismonth <- head(TravelSensorReadings$Month,1)
analysisyear <- head(TravelSensorReadings$Year,1)

# The loop will run until the variables specified in this while loop are met.
while(analysismonth != "05")
{
# This ifelse condition checks to see if the first rows hour value equals the last rows value hour.
# If the columns first hour value equals the last columns last hour value, 
# and the columns first day value equals the columns last day value the script downloads another segment.
# This ensures that every value for the hour has been downloaded prior to analysis.
if (head(TravelSensorReadings$Hour,1) == tail(TravelSensorReadings$Hour,1) & head(TravelSensorReadings$Day,1) == tail(TravelSensorReadings$Day,1)) {
  # Updates the variable to gather data from the next segment.
  segment <- (segment + limit)
  
  # Uses the API to read in the data from data.austintexas.gov.
  TravelSensorReadingsSegment <- read.socrata(
    paste("https://data.austintexas.gov/resource/2afc-qswz.json?$order=field_device_read_time ASC&$limit=",
          paste(limit), "&$offset=", paste(segment)),app_token = "YOUR_APP_TOKEN_HERE")
  
  # Extracts the Year (4-digit), Month (2-digit), Day (2-digit), and the Hour (2-digit) for the new segment.
  TravelSensorReadingsSegment$Year <- format(as.POSIXct(TravelSensorReadingsSegment$field_device_read_time, format="%Y-%m-%d %H:%M:%S"), format="%Y")
  TravelSensorReadingsSegment$Month <- format(as.POSIXct(TravelSensorReadingsSegment$field_device_read_time, format="%Y-%m-%d %H:%M:%S"), format="%m")
  TravelSensorReadingsSegment$Day <- format(as.POSIXct(TravelSensorReadingsSegment$field_device_read_time, format="%Y-%m-%d %H:%M:%S"), format="%d")
  TravelSensorReadingsSegment$Hour <- format(as.POSIXct(TravelSensorReadingsSegment$field_device_read_time, format="%Y-%m-%d %H:%M:%S"), format="%H")
  
  # Binds the two segments together.
  TravelSensorReadings <- rbind(TravelSensorReadings, TravelSensorReadingsSegment)
  
  print(paste("Lines: ", segment, "."))
} else {
  # Prepares subset of data to be analyzed for only the current analysis hour.
  HourlySummaryAnalysis <- subset(TravelSensorReadings, TravelSensorReadings$Hour == analysishour)
  
  # Summarizes the number of unique devices during the current analysis hour at each reader.
  HourlySummaryAnalysis <- ddply(HourlySummaryAnalysis,~reader_identifier,summarise,number_of_distinct_orders=length(unique(device_address)))
  
  # Attaches the current analysis year, month, day, and hour to the dataframe.
  HourlySummaryAnalysis$year <- analysisyear
  HourlySummaryAnalysis$month <- analysismonth
  HourlySummaryAnalysis$day <- analysisday
  HourlySummaryAnalysis$hour <- analysishour
  
  # Adds the hourly summary that was just analyzed to the final Hourly Summary.
  HourlySummary <- rbind(HourlySummary, HourlySummaryAnalysis)
  
  # Logic index to remove rows which have been processed.
  TravelSensorReadings <- TravelSensorReadings[!(TravelSensorReadings$Hour==analysishour & TravelSensorReadings$Day==analysisday),]
  
  # Prints message saying which data has been processed.
  print(paste("Hour ", analysishour, "for day ", analysisday, " in month ", analysismonth, " processed."))
  
  # Updates variables which determine which hour needs to be aggregated currently.
  analysishour <- head(TravelSensorReadings$Hour,1)
  analysisday <- head(TravelSensorReadings$Day,1)
  analysismonth <- head(TravelSensorReadings$Month,1)
  analysisyear <- head(TravelSensorReadings$Year,1)
}
}

# Read Travel Sensors CSV with Lat/Lon into R.
TravelSensors <- read.csv(file="Travel_Sensors.csv", header=TRUE, sep=",")

# Adds Lat/Lon to the Hourly Summary and keeps only the desired columns.
FinalHourlySummary <- merge(HourlySummary, TravelSensors, by.x='reader_identifier', by.y='READER_ID', all.x=T)
FinalHourlySummary <- select(FinalHourlySummary, 'reader_identifier', 'number_of_distinct_orders', 'year', 'month', 'day', 'hour', 'LOCATION_LATITUDE','LOCATION_LONGITUDE')

# Writes the CSV file for the Hourly Summary
write.csv(FinalHourlySummary, file = "BluetoothTrafficHourlySummary.csv",row.names=FALSE)
