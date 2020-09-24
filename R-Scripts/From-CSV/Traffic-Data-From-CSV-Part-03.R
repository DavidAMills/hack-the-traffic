library('dplyr')

Month1 <- read.csv('012016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv')
Month2 <- read.csv('022016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv')
Month3 <- read.csv('032016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv')
Month4 <- read.csv('042016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv')
Month5 <- read.csv('052016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv')
Month6 <- read.csv('062016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv')
Month7 <- read.csv('072016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv')
Month8 <- read.csv('082016-UniqueDevicesHourlyPerLocation_CorrectTimes.csv')

# Sets all Count values to 1.
Month1$Count <- 1
Month2$Count <- 1
Month3$Count <- 1
Month4$Count <- 1
Month5$Count <- 1
Month6$Count <- 1
Month7$Count <- 1
Month8$Count <- 1

# Creates sum of unique devices by Day, Hour, and Location (Monthly).
M01_24H_DHL <- Month1 %>% group_by(Reader.Identifier,Longitude,Latitude,DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M02_24H_DHL <- Month2 %>% group_by(Reader.Identifier,Longitude,Latitude,DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M03_24H_DHL <- Month3 %>% group_by(Reader.Identifier,Longitude,Latitude,DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M04_24H_DHL <- Month4 %>% group_by(Reader.Identifier,Longitude,Latitude,DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M05_24H_DHL <- Month5 %>% group_by(Reader.Identifier,Longitude,Latitude,DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M06_24H_DHL <- Month6 %>% group_by(Reader.Identifier,Longitude,Latitude,DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M07_24H_DHL <- Month7 %>% group_by(Reader.Identifier,Longitude,Latitude,DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M08_24H_DHL <- Month8 %>% group_by(Reader.Identifier,Longitude,Latitude,DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))

# Creates sum of unique devices by Hour and Location (Monthly).
M01_24H_HL <- M01_24H_DHL %>% group_by(Reader.Identifier,HourCorrected) %>% summarise(Count = sum(Count))
M02_24H_HL <- M02_24H_DHL %>% group_by(Reader.Identifier,HourCorrected) %>% summarise(Count = sum(Count))
M03_24H_HL <- M03_24H_DHL %>% group_by(Reader.Identifier,HourCorrected) %>% summarise(Count = sum(Count))
M04_24H_HL <- M04_24H_DHL %>% group_by(Reader.Identifier,HourCorrected) %>% summarise(Count = sum(Count))
M05_24H_HL <- M05_24H_DHL %>% group_by(Reader.Identifier,HourCorrected) %>% summarise(Count = sum(Count))
M06_24H_HL <- M06_24H_DHL %>% group_by(Reader.Identifier,HourCorrected) %>% summarise(Count = sum(Count))
M07_24H_HL <- M07_24H_DHL %>% group_by(Reader.Identifier,HourCorrected) %>% summarise(Count = sum(Count))
M08_24H_HL <- M08_24H_DHL %>% group_by(Reader.Identifier,HourCorrected) %>% summarise(Count = sum(Count))

# Creates sum of unique devices by Day and Location (Monthly).
M01_24H_DL <- M01_24H_DHL %>% group_by(Reader.Identifier,DayCorrected) %>% summarise(Count = sum(Count))
M02_24H_DL <- M02_24H_DHL %>% group_by(Reader.Identifier,DayCorrected) %>% summarise(Count = sum(Count))
M03_24H_DL <- M03_24H_DHL %>% group_by(Reader.Identifier,DayCorrected) %>% summarise(Count = sum(Count))
M04_24H_DL <- M04_24H_DHL %>% group_by(Reader.Identifier,DayCorrected) %>% summarise(Count = sum(Count))
M05_24H_DL <- M05_24H_DHL %>% group_by(Reader.Identifier,DayCorrected) %>% summarise(Count = sum(Count))
M06_24H_DL <- M06_24H_DHL %>% group_by(Reader.Identifier,DayCorrected) %>% summarise(Count = sum(Count))
M07_24H_DL <- M07_24H_DHL %>% group_by(Reader.Identifier,DayCorrected) %>% summarise(Count = sum(Count))
M08_24H_DL <- M08_24H_DHL %>% group_by(Reader.Identifier,DayCorrected) %>% summarise(Count = sum(Count))

# Creates sum of unique devices by Day and Location (Monthly).
M01_24H_DH <- M01_24H_DHL %>% group_by(DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M02_24H_DH <- M02_24H_DHL %>% group_by(DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M03_24H_DH <- M03_24H_DHL %>% group_by(DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M04_24H_DH <- M04_24H_DHL %>% group_by(DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M05_24H_DH <- M05_24H_DHL %>% group_by(DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M06_24H_DH <- M06_24H_DHL %>% group_by(DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M07_24H_DH <- M07_24H_DHL %>% group_by(DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))
M08_24H_DH <- M08_24H_DHL %>% group_by(DayCorrected,HourCorrected) %>% summarise(Count = sum(Count))

# Creates sum of unique devices by Hour (Monthly).
M01_24H_H <- M01_24H_HL %>% group_by(HourCorrected) %>% summarise(Count = sum(Count))
M02_24H_H <- M02_24H_HL %>% group_by(HourCorrected) %>% summarise(Count = sum(Count))
M03_24H_H <- M03_24H_HL %>% group_by(HourCorrected) %>% summarise(Count = sum(Count))
M04_24H_H <- M04_24H_HL %>% group_by(HourCorrected) %>% summarise(Count = sum(Count))
M05_24H_H <- M05_24H_HL %>% group_by(HourCorrected) %>% summarise(Count = sum(Count))
M06_24H_H <- M06_24H_HL %>% group_by(HourCorrected) %>% summarise(Count = sum(Count))
M07_24H_H <- M07_24H_HL %>% group_by(HourCorrected) %>% summarise(Count = sum(Count))
M08_24H_H <- M08_24H_HL %>% group_by(HourCorrected) %>% summarise(Count = sum(Count))

# Creates sum of unique devices by Day (Monthly).
M01_24H_D <- M01_24H_DL %>% group_by(DayCorrected) %>% summarise(Count = sum(Count))
M02_24H_D <- M02_24H_DL %>% group_by(DayCorrected) %>% summarise(Count = sum(Count))
M03_24H_D <- M03_24H_DL %>% group_by(DayCorrected) %>% summarise(Count = sum(Count))
M04_24H_D <- M04_24H_DL %>% group_by(DayCorrected) %>% summarise(Count = sum(Count))
M05_24H_D <- M05_24H_DL %>% group_by(DayCorrected) %>% summarise(Count = sum(Count))
M06_24H_D <- M06_24H_DL %>% group_by(DayCorrected) %>% summarise(Count = sum(Count))
M07_24H_D <- M07_24H_DL %>% group_by(DayCorrected) %>% summarise(Count = sum(Count))
M08_24H_D <- M08_24H_DL %>% group_by(DayCorrected) %>% summarise(Count = sum(Count))

# Creates sum of unique devices by Location (Monthly).
M01_24H_L <- M01_24H_DHL %>% group_by(Reader.Identifier,Latitude,Longitude) %>% summarise(Count = sum(Count))
M02_24H_L <- M02_24H_DHL %>% group_by(Reader.Identifier,Latitude,Longitude) %>% summarise(Count = sum(Count))
M03_24H_L <- M03_24H_DHL %>% group_by(Reader.Identifier,Latitude,Longitude) %>% summarise(Count = sum(Count))
M04_24H_L <- M04_24H_DHL %>% group_by(Reader.Identifier,Latitude,Longitude) %>% summarise(Count = sum(Count))
M05_24H_L <- M05_24H_DHL %>% group_by(Reader.Identifier,Latitude,Longitude) %>% summarise(Count = sum(Count))
M06_24H_L <- M06_24H_DHL %>% group_by(Reader.Identifier,Latitude,Longitude) %>% summarise(Count = sum(Count))
M07_24H_L <- M07_24H_DHL %>% group_by(Reader.Identifier,Latitude,Longitude) %>% summarise(Count = sum(Count))
M08_24H_L <- M08_24H_DHL %>% group_by(Reader.Identifier,Latitude,Longitude) %>% summarise(Count = sum(Count))

# Write Month 1 through 8 to CSV files. This seemed like a good place to save the work.
write.csv(M01_24H_DHL, file="M01_24H_DHL.csv")
write.csv(M02_24H_DHL, file="M02_24H_DHL.csv")
write.csv(M03_24H_DHL, file="M03_24H_DHL.csv")
write.csv(M04_24H_DHL, file="M04_24H_DHL.csv")
write.csv(M05_24H_DHL, file="M05_24H_DHL.csv")
write.csv(M06_24H_DHL, file="M06_24H_DHL.csv")
write.csv(M07_24H_DHL, file="M07_24H_DHL.csv")
write.csv(M08_24H_DHL, file="M08_24H_DHL.csv")
