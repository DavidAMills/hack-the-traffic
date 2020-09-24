install.packages("ggplot2")
install.packages("hexbin")

library(ggplot2)
library(hexbin)

# I summed the array of twenty-four hour by location data in Excel and imported the results here.
# Read Travel Sensors CSV into R.
TravelSensors <- read.csv(file="Travel_Sensors.csv", header=TRUE, sep=",")

# Read the data processed using the code above from CSV into R.
HourlySummary <- read.csv(file="24hour_sums.csv", header=TRUE, sep=",")

# Rename the first column from "row.names"
colnames(HourlySummary)[1] <- "Reader_ID"

# Merges the travel sensors dataframe which contains the latitude and longitude.
HourlySum_LatLon <- merge(HourlySummary, TravelSensors, by.x = "Reader_ID", by.y = "READER_ID", all.x = T)

# Keep only the desired columns.
HourlySum_LatLon <- HourlySum_LatLon[c(1,2,30,31)]

# Automates filling in missing Lat/Lon data due to naming discrepancies.
HourlySum_LatLon$LOCATION_LATITUDE[HourlySum_LatLon$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
HourlySum_LatLon$LOCATION_LONGITUDE[HourlySum_LatLon$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
HourlySum_LatLon$LOCATION_LATITUDE[HourlySum_LatLon$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
HourlySum_LatLon$LOCATION_LONGITUDE[HourlySum_LatLon$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
HourlySum_LatLon$LOCATION_LATITUDE[HourlySum_LatLon$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
HourlySum_LatLon$LOCATION_LONGITUDE[HourlySum_LatLon$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
HourlySum_LatLon$LOCATION_LATITUDE[HourlySum_LatLon$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
HourlySum_LatLon$LOCATION_LONGITUDE[HourlySum_LatLon$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
HourlySum_LatLon$LOCATION_LATITUDE[HourlySum_LatLon$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
HourlySum_LatLon$LOCATION_LONGITUDE[HourlySum_LatLon$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]

# Set 1st column as row names.
rownames(HourlySum_LatLon) <- HourlySum_LatLon[, 1]
# Remove 1st Column.
HourlySum_LatLon <- HourlySum_LatLon[, -1]

m<-as.data.frame(HourlySum_LatLon)
m_long <- with(m, m[rep(1:nrow(m), HourlySum_LatLon$sum_totals),])

## stat_density2d
ggplot(m_long, aes(Lat, Lon)) + 
  stat_density2d(aes(alpha=..level.., fill=..level..), size=2, 
                 bins=10, geom=c("polygon","contour")) + 
  scale_fill_gradient(low = "blue", high = "red") +
  geom_density2d(colour="black", bins=10) +
  geom_point(data = m_long)


## geom_hex alternative
bins=6
ggplot(HourlySum_LatLon, aes(LOCATION_LATITUDE, LOCATION_LONGITUDE)) + 
  geom_hex(bins=bins)+
  coord_equal(ratio = 1/1)+
  scale_fill_gradient(low = "blue", high = "red") +
  geom_point(data = HourlySum_LatLon,position = "jitter")+
  stat_binhex(aes(label=..count..,size=..count..*.5), size=3.5,geom="text", bins=bins, colour="white")
