install.packages("reshape")

library("reshape")

# Read Travel Sensors CSV into R.
TravelSensors <- read.csv(file="Travel_Sensors.csv", header=TRUE, sep=",")

#Transposes/Reshapes the data using melt and cast.
M08_24H_HL <- melt(M08_24H_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M08_24H_HL <- as.data.frame(cast(M08_24H_HL,Reader.Identifier~HourCorrected~variable))

# Creates a new dataframe for "Normalized" data.
M08_24H_HL_normalized <- M08_24H_HL

# Gets the Max Value for Each Row for the new Normalized Dataframe.
M08_24H_HL_normalized$max <- apply(M08_24H_HL_normalized,1,max, na.rm=T)

# Sets i and x values to run through 24 iterations.
i = 1
x = 24

while(i <= x)
{
  # Divides first column
  M08_24H_HL_normalized[,i] <- as.numeric(paste(M08_24H_HL_normalized[,i])) / as.numeric(as.character(M08_24H_HL_normalized$max))
  # Add 1 to i
  i = i + 1
}

# Removes the max column
M08_24H_HL_normalized$max <- NULL

# Creates an empty column to store the array.
M08_24H_HL_normalized$twentyfourhours.n <- NA
# Adds all of the values into column twentyfourhours with "," as the separator.
M08_24H_HL_normalized$twentyfourhours.n <- apply(M08_24H_HL_normalized[, 1:24], 1, paste, collapse=",")
# Remove all spaces.
M08_24H_HL_normalized$twentyfourhours.n <- gsub(" ", "", M08_24H_HL_normalized$twentyfourhours)
# Delete first 24 columns.
M08_24H_HL_normalized <- M08_24H_HL_normalized[ -c(1:24) ]
# Put brackets around values in column "twentyfourhours".
M08_24H_HL_normalized$twentyfourhours.n <- paste0("[",M08_24H_HL_normalized$twentyfourhours, "]")

# Creates an empty column to store the array.
M08_24H_HL$twentyfourhours <- NA
# Adds all of the values into column twentyfourhours with "," as the separator.
M08_24H_HL$twentyfourhours <- apply(M08_24H_HL[, 1:24], 1, paste, collapse=",")
# Remove all spaces.
M08_24H_HL$twentyfourhours <- gsub(" ", "", M08_24H_HL$twentyfourhours)
# Delete first 24 columns.
M08_24H_HL <- M08_24H_HL[ -c(1:24) ]
# Put brackets around values in column "twentyfourhours".
M08_24H_HL$twentyfourhours <- paste0("[",M08_24H_HL$twentyfourhours, "]")

# Merges the normalized dataframe with the un-normalized dataframe.
M08_24H_HL <- merge(M08_24H_HL, M08_24H_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
# Merges the travel sensors dataframe which contains the latitude and longitude.
M08_24H_HL <- merge(M08_24H_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)

# Rename the first column from "Row.names"
colnames(M08_24H_HL)[1] <- "Reader_ID"

# Keep only the desired columns.
M08_24H_HL <- M08_24H_HL[c(1,2,3,31,32)]

# Adds Longitude and Latitude values that were missed due to naming discrepancies.
M08_24H_HL$LOCATION_LATITUDE[M08_24H_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M08_24H_HL$LOCATION_LONGITUDE[M08_24H_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M08_24H_HL$LOCATION_LATITUDE[M08_24H_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M08_24H_HL$LOCATION_LONGITUDE[M08_24H_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]

# Writes the file to a CSV.
write.csv(M08_24H_HL, "M08_24H_HL.csv")
