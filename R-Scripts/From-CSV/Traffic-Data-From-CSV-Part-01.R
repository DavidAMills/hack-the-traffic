### UNUSED CODE
# Creates empty dataframes to store Data with final columns.
#CountHourlyDuplicateDevices <- data.frame(matrix(ncol = 6, nrow = 0))
#x <- c('Reader.Identifier','Device.Address','Month','Day','Hour')
#colnames(CountHourlyDuplicateDevices) <- x
#HourlyAggregatedUniqueDeviceCount <- CountHourlyDuplicateDevices

install.packages('RSQLite')
install.packages('DBI')
install.packages('lubridate')
install.packages('dplyr')
install.packages('plyr')
install.packages('reshape2')

library(RSQLite)
library(DBI)
library(lubridate)
library(dplyr)
library(reshape2)

# Connect to the Database
con <- dbConnect(RSQLite::SQLite(), dbname = "bluetooth_db")

###(YOU ONLY NEED TO RUN THE FOLLOWING COMMAND FOR INITIAL DATABASE CREATION) 
# Read csv file into SQL Database
# dbWriteTable(con, name="bluetooth_data", value="Bluetooth_Travel_Sensors.csv", 
#             row.names=FALSE, header=TRUE, sep = ",")

# Set this value to the number of lines you would like processed during each interval.
offset <- as.integer(0)
limit <- as.integer(50000)

# Query the database
TravelSensorReadings <- as.data.frame(dbGetQuery(con, paste("SELECT * FROM bluetooth_data LIMIT ", paste(limit), " OFFSET ", paste(offset))))

# Extracts Month (2-digit), Day (2-digit), , Hour (2-digit).
TravelSensorReadings$Month <- month(as.POSIXct(TravelSensorReadings$Field.Device.Read.Time, format="%m/%d/%Y %I:%M:%S %p"))
TravelSensorReadings$Day <- day(as.POSIXct(TravelSensorReadings$Field.Device.Read.Time, format="%m/%d/%Y %I:%M:%S %p"))
TravelSensorReadings$Hour <- hour(as.POSIXct(TravelSensorReadings$Field.Device.Read.Time, format="%m/%d/%Y %I:%M:%S %p"))
# Adds the Count column.
TravelSensorReadings$Count <- 1

# Subsets TravelSensorReadings into eight data frames holding Jan-Aug data.
for (i in 1:8)
{
  as.data.frame(assign(paste0("Month", i), data.frame(subset(TravelSensorReadings, Month==i))))
}

# Loops through the eight months.
for (i in 1:8)
{
  # Only runs if the dataframe contains at least one row.
  if (nrow(eval(parse(text = paste0("Month",i)))) > 0)
  {
    # Sums the counts if the Reader.Identifier,Device.Address.Day.Hour all match.
    assign(paste0("Month",i), 
              aggregate(Count~Reader.Identifier+Device.Address+Day+Hour, 
              eval(parse(text = paste0("Month",i))), 
              sum))
  }
}

# Takes 5.200957 hours on the 3rd floor lab computers.
start_time <- Sys.time()
# There are just under 82,000,000 records in the database.
while(offset<82000000)
{
# Updates the offset to get the next 50,000 records.
offset <- offset + limit

# Query the database
TravelSensorReadings <- as.data.frame(dbGetQuery(con, paste("SELECT * FROM bluetooth_data LIMIT ", paste(limit), " OFFSET ", paste(offset))))

# Extracts Month (2-digit), Day (2-digit), , Hour (2-digit).
TravelSensorReadings$Month <- month(as.POSIXct(TravelSensorReadings$Field.Device.Read.Time, format="%m/%d/%Y %I:%M:%S %p"))
TravelSensorReadings$Day <- day(as.POSIXct(TravelSensorReadings$Field.Device.Read.Time, format="%m/%d/%Y %I:%M:%S %p"))
TravelSensorReadings$Hour <- hour(as.POSIXct(TravelSensorReadings$Field.Device.Read.Time, format="%m/%d/%Y %I:%M:%S %p"))
# Adds the Count column.
TravelSensorReadings$Count <- 1

# Subsets TravelSensorReadings into eight data frames holding Jan-Aug data.
for (i in 1:8)
{
  as.data.frame(assign(paste0("Bind", i), data.frame(subset(TravelSensorReadings, Month==i))))
}

# Loops through the eight months.
for (i in 1:8)
{
  # Only runs if the dataframe contains at least one row.
  if (nrow(eval(parse(text = paste0("Bind",i)))) > 0)
  {
    # Sums the counts if the Reader.Identifier,Device.Address.Day.Hour all match.
    assign(paste0("Bind",i), 
           aggregate(Count~Reader.Identifier+Device.Address+Day+Hour, 
                     eval(parse(text = paste0("Bind",i))), 
                     sum))
    assign(paste0("Month",i),
           rbind(eval(parse(text = paste0("Month",i))),
                 eval(parse(text = paste0("Bind",i)))))
  }
}
}
end_time <- Sys.time()
end_time - start_time

# Takes 26.1919 minutes on the 3rd floor lab computers.
start_time <- Sys.time()
# After binding the Bind(i) and Month(i) records, we need to sum the count for hourly at duplicate locations again.
for (i in 1:8)
{
  # Sums the counts if the Reader.Identifier,Device.Address.Day.Hour all match.
  assign(paste0("Month",i), 
         aggregate(Count~Reader.Identifier+Device.Address+Day+Hour, 
                   eval(parse(text = paste0("Month",i))), 
                   sum))
}
end_time <- Sys.time()
end_time - start_time

# Read in Travel Sensor Locations.
TravelSensorLocations <- read.csv('Travel_Sensors.csv')

# Month 1 Add Latitude/Longitude and fix the missing latitude/longitude due to name discrepancies.
Month1$Latitude <- TravelSensorLocations$LOCATION_LATITUDE[match(Month1$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month1$Longitude <- TravelSensorLocations$LOCATION_LONGITUDE[match(Month1$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month1$Latitude[Month1$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month1$Longitude[Month1$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month1$Latitude[Month1$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month1$Longitude[Month1$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month1$Latitude[Month1$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month1$Longitude[Month1$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month1$Latitude[Month1$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month1$Longitude[Month1$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month1$Latitude[Month1$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
Month1$Longitude[Month1$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
# Month 2 Add Latitude/Longitude and fix the missing latitude/longitude due to name discrepancies.
Month2$Latitude <- TravelSensorLocations$LOCATION_LATITUDE[match(Month2$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month2$Longitude <- TravelSensorLocations$LOCATION_LONGITUDE[match(Month2$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month2$Latitude[Month2$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month2$Longitude[Month2$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month2$Latitude[Month2$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month2$Longitude[Month2$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month2$Latitude[Month2$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month2$Longitude[Month2$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month2$Latitude[Month2$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month2$Longitude[Month2$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month2$Latitude[Month2$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
Month2$Longitude[Month2$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
# Month 3 Add Latitude/Longitude and fix the missing latitude/longitude due to name discrepancies.
Month3$Latitude <- TravelSensorLocations$LOCATION_LATITUDE[match(Month3$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month3$Longitude <- TravelSensorLocations$LOCATION_LONGITUDE[match(Month3$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month3$Latitude[Month3$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month3$Longitude[Month3$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month3$Latitude[Month3$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month3$Longitude[Month3$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month3$Latitude[Month3$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month3$Longitude[Month3$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month3$Latitude[Month3$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month3$Longitude[Month3$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month3$Latitude[Month3$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
Month3$Longitude[Month3$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
# Month 4 Add Latitude/Longitude and fix the missing latitude/longitude due to name discrepancies.
Month4$Latitude <- TravelSensorLocations$LOCATION_LATITUDE[match(Month4$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month4$Longitude <- TravelSensorLocations$LOCATION_LONGITUDE[match(Month4$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month4$Latitude[Month4$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month4$Longitude[Month4$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month4$Latitude[Month4$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month4$Longitude[Month4$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month4$Latitude[Month4$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month4$Longitude[Month4$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month4$Latitude[Month4$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month4$Longitude[Month4$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month4$Latitude[Month4$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
Month4$Longitude[Month4$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
# Month 5 Add Latitude/Longitude and fix the missing latitude/longitude due to name discrepancies.
Month5$Latitude <- TravelSensorLocations$LOCATION_LATITUDE[match(Month5$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month5$Longitude <- TravelSensorLocations$LOCATION_LONGITUDE[match(Month5$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month5$Latitude[Month5$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month5$Longitude[Month5$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month5$Latitude[Month5$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month5$Longitude[Month5$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month5$Latitude[Month5$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month5$Longitude[Month5$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month5$Latitude[Month5$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month5$Longitude[Month5$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month5$Latitude[Month5$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
Month5$Longitude[Month5$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
# Month 6 Add Latitude/Longitude and fix the missing latitude/longitude due to name discrepancies.
Month6$Latitude <- TravelSensorLocations$LOCATION_LATITUDE[match(Month6$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month6$Longitude <- TravelSensorLocations$LOCATION_LONGITUDE[match(Month6$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month6$Latitude[Month6$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month6$Longitude[Month6$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month6$Latitude[Month6$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month6$Longitude[Month6$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month6$Latitude[Month6$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month6$Longitude[Month6$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month6$Latitude[Month6$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month6$Longitude[Month6$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month6$Latitude[Month6$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
Month6$Longitude[Month6$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
# Month 7 Add Latitude/Longitude and fix the missing latitude/longitude due to name discrepancies.
Month7$Latitude <- TravelSensorLocations$LOCATION_LATITUDE[match(Month7$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month7$Longitude <- TravelSensorLocations$LOCATION_LONGITUDE[match(Month7$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month7$Latitude[Month7$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month7$Longitude[Month7$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month7$Latitude[Month7$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month7$Longitude[Month7$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month7$Latitude[Month7$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month7$Longitude[Month7$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month7$Latitude[Month7$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month7$Longitude[Month7$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month7$Latitude[Month7$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
Month7$Longitude[Month7$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
# Month 8 Add Latitude/Longitude and fix the missing latitude/longitude due to name discrepancies.
Month8$Latitude <- TravelSensorLocations$LOCATION_LATITUDE[match(Month8$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month8$Longitude <- TravelSensorLocations$LOCATION_LONGITUDE[match(Month8$Reader.Identifier, TravelSensorLocations$READER_ID)]
Month8$Latitude[Month8$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month8$Longitude[Month8$Reader.Identifier=="cesar_chavez_ih_35"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="cesar_chavez_ih35"]
Month8$Latitude[Month8$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month8$Longitude[Month8$Reader.Identifier=="fm_2222_loop360"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="fm2222_loop360"]
Month8$Latitude[Month8$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month8$Longitude[Month8$Reader.Identifier=="ih_35_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="riverside_ih35"]
Month8$Latitude[Month8$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month8$Longitude[Month8$Reader.Identifier=="lamar_brodie_oak"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="Lamar_BrodieOaks"]
Month8$Latitude[Month8$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LATITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]
Month8$Longitude[Month8$Reader.Identifier=="benWhite_riverside"] <- TravelSensorLocations$LOCATION_LONGITUDE[TravelSensorLocations$READER_ID=="benwhite_riverside"]

# Write Month 1 through 8 to CSV files. This seemed like a good place to save the work.
write.csv(Month1, file="012016-UniqueDevicesHourlyPerLocation.csv")
write.csv(Month2, file="022016-UniqueDevicesHourlyPerLocation.csv")
write.csv(Month3, file="032016-UniqueDevicesHourlyPerLocation.csv")
write.csv(Month4, file="042016-UniqueDevicesHourlyPerLocation.csv")
write.csv(Month5, file="052016-UniqueDevicesHourlyPerLocation.csv")
write.csv(Month6, file="062016-UniqueDevicesHourlyPerLocation.csv")
write.csv(Month7, file="072016-UniqueDevicesHourlyPerLocation.csv")
write.csv(Month8, file="082016-UniqueDevicesHourlyPerLocation.csv")