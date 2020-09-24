# Read the data processed using the code above from CSV into R.
HourlySummary <- read.csv(file="Sept6HourlySummary.csv", header=TRUE, sep=",")

# Remove hours that will precede the study time scale after corrections are made.
HourlySummarySept6 <- HourlySummary[!(HourlySummary$month == 1 & HourlySummary$day == 1 & HourlySummary$hour <= 11),]

# Remove hours that will excede the study time scale after corrections are made.
HourlySummarySept6 <- HourlySummarySept6[!(HourlySummarySept6$month == 5 & HourlySummarySept6$day == 1 & HourlySummarySept6$hour >= 11),]

# Corrects times.
HourlySummarySept6 <- transform(HourlySummarySept6, HourCorrected = ifelse(hour >= 12, hour - 12, hour + 12))
HourlySummarySept6 <- transform(HourlySummarySept6, DayCorrected = ifelse(hour >= 12, day, day - 1))

# Corrects the Month and Day for DayCorrected == 0.
# February 1 to January 31
HourlySummarySept6$MonthCorrected[HourlySummarySept6$DayCorrected==0 & HourlySummarySept6$month==2] <- 1
HourlySummarySept6$DayCorrected[HourlySummarySept6$DayCorrected==0 & HourlySummarySept6$MonthCorrected==1] <- 31
# March 1 to February 29
HourlySummarySept6$MonthCorrected[HourlySummarySept6$DayCorrected==0 & HourlySummarySept6$month==3] <- 2
HourlySummarySept6$DayCorrected[HourlySummarySept6$DayCorrected==0 & HourlySummarySept6$MonthCorrected==2] <- 29

# Gives + 1 hour for March 13th after 1400 (11 hour difference).
HourlySummarySept6$HourCorrected[HourlySummarySept6$day==13 & HourlySummarySept6$month==3 & HourlySummarySept6$hour >= 14] <-
  HourlySummarySept6$HourCorrected[HourlySummarySept6$day==13 & HourlySummarySept6$month==3 & HourlySummarySept6$hour >= 14] + 1

# Gives + 1 hour for March 14th - March 31st (11 hour difference).
HourlySummarySept6$HourCorrected[HourlySummarySept6$day>=14 & HourlySummarySept6$month==3] <-
  HourlySummarySept6$HourCorrected[HourlySummarySept6$day>=14 & HourlySummarySept6$month==3] + 1

# Gives + 1 hour for April (11 hour difference).
HourlySummarySept6$HourCorrected[HourlySummarySept6$month>=4] <-
  HourlySummarySept6$HourCorrected[HourlySummarySept6$month>=4] + 1

# Adds + 1 to DayCorrected where hour == 11 and HourCorrected == 24
HourlySummarySept6$DayCorrected[HourlySummarySept6$hour==11 & HourlySummarySept6$HourCorrected==24] <-
  HourlySummarySept6$DayCorrected[HourlySummarySept6$hour==11 & HourlySummarySept6$HourCorrected==24] + 1

# Fixes HourCorrected == 24 to HourCorrected == 0
HourlySummarySept6$HourCorrected[HourlySummarySept6$HourCorrected==24] <- 0

# Corrects Month and Day for DayCorrected == 0
# May 1 to April 30
HourlySummarySept6$MonthCorrected[HourlySummarySept6$month==5] <- 4
HourlySummarySept6$DayCorrected[HourlySummarySept6$month==5] <- 30
# April 1 to March 31
HourlySummarySept6$MonthCorrected[HourlySummarySept6$month==4 & HourlySummarySept6$DayCorrected==0] <- 3
HourlySummarySept6$DayCorrected[HourlySummarySept6$month==4 & HourlySummarySept6$DayCorrected==0] <- 31

# Replaces MonthCorrected NA Values with month values
HourlySummarySept6$MonthCorrected[is.na(HourlySummarySept6$MonthCorrected)] <- 
  HourlySummarySept6$month[is.na(HourlySummarySept6$MonthCorrected)]

# Finalizes the Cleaned Data
HourlySummarySept6$day <- HourlySummarySept6$DayCorrected
HourlySummarySept6$hour <- HourlySummarySept6$HourCorrected
HourlySummarySept6$month <- HourlySummarySept6$MonthCorrected

# Writes the CSV file for the updated Hourly Summary
write.csv(HourlySummarySept6, file = "Sept6HourlySummaryFinal.csv",row.names=FALSE)
