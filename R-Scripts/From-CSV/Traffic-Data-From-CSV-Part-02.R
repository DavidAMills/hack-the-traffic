Month1 <- read.csv('012016-UniqueDevicesHourlyPerLocation.csv')
Month2 <- read.csv('022016-UniqueDevicesHourlyPerLocation.csv')
Month3 <- read.csv('032016-UniqueDevicesHourlyPerLocation.csv')
Month4 <- read.csv('042016-UniqueDevicesHourlyPerLocation.csv')
Month5 <- read.csv('052016-UniqueDevicesHourlyPerLocation.csv')
Month6 <- read.csv('062016-UniqueDevicesHourlyPerLocation.csv')
Month7 <- read.csv('072016-UniqueDevicesHourlyPerLocation.csv')
Month8 <- read.csv('082016-UniqueDevicesHourlyPerLocation.csv')

# Remove hours that will precede the study time scale after corrections are made (533 records removed).
Month1 <- Month1[!(Month1$Day == 1 & Month1$Hour <= 11),]
# Corrects Day and Hour for January.
Month1 <- transform(Month1, HourCorrected = ifelse(Hour >= 12, Hour - 12, Hour + 12))
Month1 <- transform(Month1, DayCorrected = ifelse(Hour >= 12, Day, Day - 1))
# Corrects Day and Hour for February.
Month2 <- transform(Month2, HourCorrected = ifelse(Hour >= 12, Hour - 12, Hour + 12))
Month2 <- transform(Month2, DayCorrected = ifelse(Hour >= 12, Day, Day - 1))
# Corrects Day and Hour for March.
Month3 <- transform(Month3, HourCorrected = ifelse(Hour >= 12, Hour - 12, Hour + 12))
Month3 <- transform(Month3, DayCorrected = ifelse(Hour >= 12, Day, Day - 1))
# Gives + 1 hour for March 13th after 1400 (11 hour difference).
Month3$HourCorrected[Month3$day==13 & Month3$hour >= 14] <-
  Month3$HourCorrected[Month3$day==13 & Month3$hour >= 14] + 1
# Corrects Day and Hour for April.
Month4 <- transform(Month4, HourCorrected = ifelse(Hour >= 11, Hour - 11, Hour + 13))
Month4 <- transform(Month4, DayCorrected = ifelse(Hour >= 11, Day, Day - 1))
# Corrects Day and Hour for May.
Month5 <- transform(Month5, HourCorrected = ifelse(Hour >= 11, Hour - 11, Hour + 13))
Month5 <- transform(Month5, DayCorrected = ifelse(Hour >= 11, Day, Day - 1))
# Corrects Day and Hour for June.
Month6 <- transform(Month6, HourCorrected = ifelse(Hour >= 11, Hour - 11, Hour + 13))
Month6 <- transform(Month6, DayCorrected = ifelse(Hour >= 11, Day, Day - 1))
# Corrects Day and Hour for July.
Month7 <- transform(Month7, HourCorrected = ifelse(Hour >= 11, Hour - 11, Hour + 13))
Month7 <- transform(Month7, DayCorrected = ifelse(Hour >= 11, Day, Day - 1))
# Corrects Day and Hour for August.
Month8 <- transform(Month8, HourCorrected = ifelse(Hour >= 11, Hour - 11, Hour + 13))
Month8 <- transform(Month8, DayCorrected = ifelse(Hour >= 11, Day, Day - 1))

# Binds Day 0 to preceding month, then removes binded rows from original dataframe.
Month1 <- rbind(Month1,Month2[which(Month2$DayCorrected == 0), ])
Month2 <- Month2[!(Month2$DayCorrected == 0),]
Month2 <- rbind(Month2,Month3[which(Month3$DayCorrected == 0), ])
Month3 <- Month3[!(Month3$DayCorrected == 0),]
Month3 <- rbind(Month3,Month4[which(Month4$DayCorrected == 0), ])
Month4 <- Month4[!(Month4$DayCorrected == 0),]
Month4 <- rbind(Month4,Month5[which(Month5$DayCorrected == 0), ])
Month5 <- Month5[!(Month5$DayCorrected == 0),]
Month5 <- rbind(Month5,Month6[which(Month6$DayCorrected == 0), ])
Month6 <- Month6[!(Month6$DayCorrected == 0),]
Month6 <- rbind(Month6,Month7[which(Month7$DayCorrected == 0), ])
Month7 <- Month7[!(Month7$DayCorrected == 0),]
Month7 <- rbind(Month7,Month8[which(Month8$DayCorrected == 0), ])
Month8 <- Month8[!(Month8$DayCorrected == 0),]

# Changes DayCorrected == 0 to the last day of the Month.
Month1$DayCorrected[Month1$DayCorrected == 0] <- 31
Month2$DayCorrected[Month2$DayCorrected == 0] <- 29
Month3$DayCorrected[Month3$DayCorrected == 0] <- 31
Month4$DayCorrected[Month4$DayCorrected == 0] <- 30
Month5$DayCorrected[Month5$DayCorrected == 0] <- 31
Month6$DayCorrected[Month6$DayCorrected == 0] <- 30
Month7$DayCorrected[Month7$DayCorrected == 0] <- 31

# Write Month 1 through 8 to CSV files.
write.csv(Month1, file="012016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv")
write.csv(Month2, file="022016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv")
write.csv(Month3, file="032016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv")
write.csv(Month4, file="042016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv")
write.csv(Month5, file="052016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv")
write.csv(Month6, file="062016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv")
write.csv(Month7, file="072016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv")
write.csv(Month8, file="082016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv")
