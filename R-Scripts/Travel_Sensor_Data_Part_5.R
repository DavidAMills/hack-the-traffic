# Loads the package library.
library("RSocrata")
library("lubridate")
library("plyr")
library("dplyr")

# Read Travel Sensors CSV into R.
TravelSensors <- read.csv(file="Travel_Sensors.csv", header=TRUE, sep=",")

# Read the data processed using the code above from CSV into R.
HourlySummary <- read.csv(file="Sept6HourlySummaryFinal.csv", header=TRUE, sep=",")

# Creates sum of each hour for unique devices at each location.
TwentyFourHourSum <- HourlySummary %>% group_by(reader_identifier,hour) %>% summarise(number_of_distinct_orders = sum(number_of_distinct_orders))

# Transposes the Data
TwentyFourHourSum <- as.data.frame(t(TwentyFourHourSum))

# Make the hours the column names.
colnames(TwentyFourHourSum) = as.character(unlist(TwentyFourHourSum[2, ]))

# Remove the hours row.
TwentyFourHourSum = TwentyFourHourSum[-2, ]

# These numbers are based on having 24 values (hours) to rearrange and used for the while loop.
i = 1
x = 24
# Create the new dataframe for re-organizing the data.
agg_bluetooth_data <- TwentyFourHourSum[i:x]
# Makes the reader_identifier value the row name for the number_of_distinct_orders.
row.names(agg_bluetooth_data)[2]<-as.character(agg_bluetooth_data[1,1])
# Deletes the reader_identifier row.
agg_bluetooth_data <- agg_bluetooth_data[-c(1), ]

# Loop runs while there are still obersvations (3216 observations) to be reorganized.
while(x <= 3216)
{
  # Add 24 to i to mark beginning of next row
  i = i + 24
  # Add 24 to x to mark end of next row and continue or end loop on next iteration.
  x = x + 24
  
  # Creates a "newRow" dataframe from the selected columns.
  newRow <- TwentyFourHourSum[i:x]
  # Makes the reader_identifier value the row name for the number_of_distinct_orders.
  row.names(newRow)[2]<-as.character(newRow[1,1])
  # Deletes the reader_identifier row.
  newRow <- newRow[-c(1), ]
  # Binds newRow to the aggregated bluetooth data dataframe.
  agg_bluetooth_data <- rbind(agg_bluetooth_data,newRow)
}

# Creates an empty column to store the array.
agg_bluetooth_data$twentyfourhours <- NA

# Adds all of the values into column twentyfourhours with "," as the separator.
agg_bluetooth_data$twentyfourhours <- apply(agg_bluetooth_data[, 1:24], 1, paste, collapse=",")

# Remove all spaces.
agg_bluetooth_data$twentyfourhours <- gsub(" ", "", agg_bluetooth_data$twentyfourhours)

# Delete first 24 columns.
agg_bluetooth_data <- agg_bluetooth_data[ -c(1:24) ]

# Merges the travel sensors dataframe which contains the latitude and longitude.
AggBluetoothFinal <- merge(agg_bluetooth_data, TravelSensors, by.x = "row.names", by.y = "READER_ID", all.x = T)

# Rename the first column from "row.names"
colnames(AggBluetoothFinal)[1] <- "Reader_ID"

# Keep only the desired columns.
AggBluetoothFinal <- AggBluetoothFinal[c(1,2,30,31)]

# Put brackets around values in column "twentyfourhours.
AggBluetoothFinal$twentyfourhours <- paste0("[",AggBluetoothFinal$twentyfourhours, "]")

# Automates filling in missing Lat/Lon data due to naming discrepancies.
AggBluetoothFinal$LOCATION_LATITUDE[AggBluetoothFinal$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
AggBluetoothFinal$LOCATION_LONGITUDE[AggBluetoothFinal$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
AggBluetoothFinal$LOCATION_LATITUDE[AggBluetoothFinal$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
AggBluetoothFinal$LOCATION_LONGITUDE[AggBluetoothFinal$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
AggBluetoothFinal$LOCATION_LATITUDE[AggBluetoothFinal$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
AggBluetoothFinal$LOCATION_LONGITUDE[AggBluetoothFinal$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
AggBluetoothFinal$LOCATION_LATITUDE[AggBluetoothFinal$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
AggBluetoothFinal$LOCATION_LONGITUDE[AggBluetoothFinal$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
AggBluetoothFinal$LOCATION_LATITUDE[AggBluetoothFinal$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
AggBluetoothFinal$LOCATION_LONGITUDE[AggBluetoothFinal$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]

# Exports as the AggTwentyFourHour.csv
write.csv(AggBluetoothFinal, file = "Sept6_AggTwentyFourHour.csv",row.names=FALSE)
