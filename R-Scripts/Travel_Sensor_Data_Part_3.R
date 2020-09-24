# Install the necessary packages.
install.packages("RSocrata")
install.packages("lubridate")
install.packages("plyr")
install.packages("dplyr")

library(lubridate)
library(RSocrata)
library(plyr)
library(dplyr)

# Read the data processed using the code above from CSV into R.
HourlySummary <- read.csv(file="BluetoothTrafficHourlySummary_CorrectedLatLon.csv", header=TRUE, sep=",")

# These values are set to grab a data in the range that contains May 1, 2016.
offset <- as.integer(40000000)
limit <- as.integer(2000000)

# Starts timer to time the download, must run end_time lines while read_socrata is operating to get the end time to automate.
start_time <- Sys.time()
# Uses the API to read in the data from data.austintexas.gov.
TravelSensorReadingsSegment <- read.socrata(
  paste("https://data.austintexas.gov/resource/2afc-qswz.json?$order=field_device_read_time ASC&$limit=",
        paste(limit), "&$offset=", paste(offset)),app_token = "YOUR_APP_TOKEN_HERE")
end_time <- Sys.time()
end_time - start_time

# Extracts the Year (4-digit), Month (2-digit), Day (2-digit), and the Hour (2-digit) for the new segment.
TravelSensorReadingsSegment$Year <- format(as.POSIXct(TravelSensorReadingsSegment$field_device_read_time, format="%Y-%m-%d %H:%M:%S"), format="%Y")
TravelSensorReadingsSegment$Month <- format(as.POSIXct(TravelSensorReadingsSegment$field_device_read_time, format="%Y-%m-%d %H:%M:%S"), format="%m")
TravelSensorReadingsSegment$Day <- format(as.POSIXct(TravelSensorReadingsSegment$field_device_read_time, format="%Y-%m-%d %H:%M:%S"), format="%d")
TravelSensorReadingsSegment$Hour <- format(as.POSIXct(TravelSensorReadingsSegment$field_device_read_time, format="%Y-%m-%d %H:%M:%S"), format="%H")

# Keeps rows for May 1, 2016.
TravelSensorReadings <- TravelSensorReadingsSegment[ which(TravelSensorReadingsSegment$Month=='05' 
                         & TravelSensorReadingsSegment$Day=='01'), ]

# Updates variables which determine the hour that needs to be aggregated currently.
analysishour <- head(TravelSensorReadings$Hour,1)
analysisday <- head(TravelSensorReadings$Day,1)
analysismonth <- head(TravelSensorReadings$Month,1)
analysisyear <- head(TravelSensorReadings$Year,1)

# Read Travel Sensors CSV with Lat/Lon into R.
TravelSensors <- read.csv(file="Travel_Sensors.csv", header=TRUE, sep=",")

while(analysishour <= 23)
{
# Prepares subset of data to be analyzed for only the current analysis hour.
HourlySummaryAnalysis <- subset(TravelSensorReadings, TravelSensorReadings$Hour == analysishour)

# Summarizes the number of unique devices during the current analysis hour at each reader.
HourlySummaryAnalysis <- ddply(HourlySummaryAnalysis,~reader_identifier,summarise,number_of_distinct_orders=length(unique(device_address)))

# Attaches the current analysis year, month, day, and hour to the dataframe.
HourlySummaryAnalysis$year <- analysisyear
HourlySummaryAnalysis$month <- analysismonth
HourlySummaryAnalysis$day <- analysisday
HourlySummaryAnalysis$hour <- analysishour

# Adds Lat/Lon to the Hourly Summary Analysis to match the Hourly Summary columns and keeps only the desired columns.
HourlySummaryAnalysis <- merge(HourlySummaryAnalysis, TravelSensors, by.x='reader_identifier', by.y='READER_ID', all.x=T)
HourlySummaryAnalysis <- select(HourlySummaryAnalysis, 'reader_identifier', 'number_of_distinct_orders', 'year', 'month', 'day', 'hour', 'LOCATION_LATITUDE','LOCATION_LONGITUDE')

# Automates filling in missing Lat/Lon data due to naming discrepancies.
HourlySummaryAnalysis$LOCATION_LATITUDE[HourlySummaryAnalysis$reader_identifier=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
HourlySummaryAnalysis$LOCATION_LONGITUDE[HourlySummaryAnalysis$reader_identifier=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
HourlySummaryAnalysis$LOCATION_LATITUDE[HourlySummaryAnalysis$reader_identifier=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
HourlySummaryAnalysis$LOCATION_LONGITUDE[HourlySummaryAnalysis$reader_identifier=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
HourlySummaryAnalysis$LOCATION_LATITUDE[HourlySummaryAnalysis$reader_identifier=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
HourlySummaryAnalysis$LOCATION_LONGITUDE[HourlySummaryAnalysis$reader_identifier=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]

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

# Get rid of leading zeroes (IE. "05" in month).
HourlySummary$month <- as.integer(HourlySummary$month)
HourlySummary$day <- as.integer(HourlySummary$day)
HourlySummary$hour <- as.integer(HourlySummary$hour)

# Writes the CSV file for the updated Hourly Summary
write.csv(HourlySummary, file = "Sept6HourlySummary.csv",row.names=FALSE)