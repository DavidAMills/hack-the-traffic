install.packages('ggplot2')
install.packages('directlabels')

library("dplyr")
library("ggplot2")
library("scales")
library("directlabels")

# Keeps only the day specified in a new dataframe.
M05_D28_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 28), ]
M05_D29_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 29), ]
M05_D30_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 30), ]

M05_D07_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 7), ]
M05_D08_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 8), ]
M05_D14_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 14), ]
M05_D15_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 15), ]
M05_D21_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 21), ]
M05_D22_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 22), ]

M05_D23_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 23), ]
M05_D24_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 24), ]
M05_D25_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 25), ]
M05_D26_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 26), ]
M05_D27_HL <- M05_24H_DHL[which(M05_24H_DHL$DayCorrected == 27), ]

# Remove the DayCorrected Column.
M05_D28_HL <- M05_D28_HL[,-c(2)]
M05_D29_HL <- M05_D29_HL[,-c(2)]
M05_D30_HL <- M05_D30_HL[,-c(2)]

M05_D07_HL <- M05_D07_HL[,-c(2)]
M05_D08_HL <- M05_D08_HL[,-c(2)]
M05_D14_HL <- M05_D14_HL[,-c(2)]
M05_D15_HL <- M05_D15_HL[,-c(2)]
M05_D21_HL <- M05_D21_HL[,-c(2)]
M05_D22_HL <- M05_D22_HL[,-c(2)]

M05_D23_HL <- M05_D23_HL[,-c(2)]
M05_D24_HL <- M05_D24_HL[,-c(2)]
M05_D25_HL <- M05_D25_HL[,-c(2)]
M05_D26_HL <- M05_D26_HL[,-c(2)]
M05_D27_HL <- M05_D27_HL[,-c(2)]

#Transposes/Reshapes the data using melt and cast.
M05_D28_HL <- melt(M05_D28_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D28_HL <- as.data.frame(cast(M05_D28_HL,Reader.Identifier~HourCorrected~variable))
M05_D29_HL <- melt(M05_D29_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D29_HL <- as.data.frame(cast(M05_D29_HL,Reader.Identifier~HourCorrected~variable))
M05_D30_HL <- melt(M05_D30_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D30_HL <- as.data.frame(cast(M05_D30_HL,Reader.Identifier~HourCorrected~variable))

M05_D07_HL <- melt(M05_D07_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D07_HL <- as.data.frame(cast(M05_D07_HL,Reader.Identifier~HourCorrected~variable))
M05_D08_HL <- melt(M05_D08_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D08_HL <- as.data.frame(cast(M05_D08_HL,Reader.Identifier~HourCorrected~variable))
M05_D14_HL <- melt(M05_D14_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D14_HL <- as.data.frame(cast(M05_D14_HL,Reader.Identifier~HourCorrected~variable))
M05_D15_HL <- melt(M05_D15_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D15_HL <- as.data.frame(cast(M05_D15_HL,Reader.Identifier~HourCorrected~variable))
M05_D21_HL <- melt(M05_D21_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D21_HL <- as.data.frame(cast(M05_D21_HL,Reader.Identifier~HourCorrected~variable))
M05_D22_HL <- melt(M05_D22_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D22_HL <- as.data.frame(cast(M05_D22_HL,Reader.Identifier~HourCorrected~variable))

M05_D23_HL <- melt(M05_D23_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D23_HL <- as.data.frame(cast(M05_D23_HL,Reader.Identifier~HourCorrected~variable))
M05_D24_HL <- melt(M05_D24_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D24_HL <- as.data.frame(cast(M05_D24_HL,Reader.Identifier~HourCorrected~variable))
M05_D25_HL <- melt(M05_D25_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D25_HL <- as.data.frame(cast(M05_D25_HL,Reader.Identifier~HourCorrected~variable))
M05_D26_HL <- melt(M05_D26_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D26_HL <- as.data.frame(cast(M05_D26_HL,Reader.Identifier~HourCorrected~variable))
M05_D27_HL <- melt(M05_D27_HL,id.vars=c("Reader.Identifier","HourCorrected"))
M05_D27_HL <- as.data.frame(cast(M05_D27_HL,Reader.Identifier~HourCorrected~variable))

# Creates a new dataframe for "Normalized" data.
M05_D28_HL_normalized <- M05_D28_HL
M05_D29_HL_normalized <- M05_D29_HL
M05_D30_HL_normalized <- M05_D30_HL

M05_D07_HL_normalized <- M05_D07_HL
M05_D08_HL_normalized <- M05_D08_HL
M05_D14_HL_normalized <- M05_D14_HL
M05_D15_HL_normalized <- M05_D15_HL
M05_D21_HL_normalized <- M05_D21_HL
M05_D22_HL_normalized <- M05_D22_HL

M05_D23_HL_normalized <- M05_D23_HL
M05_D24_HL_normalized <- M05_D24_HL
M05_D25_HL_normalized <- M05_D25_HL
M05_D26_HL_normalized <- M05_D26_HL
M05_D27_HL_normalized <- M05_D27_HL

# Gets the Max Value for Each Row for the new Normalized Dataframe.
M05_D28_HL_normalized$max <- apply(M05_D28_HL_normalized,1,max, na.rm=T)
M05_D29_HL_normalized$max <- apply(M05_D29_HL_normalized,1,max, na.rm=T)
M05_D30_HL_normalized$max <- apply(M05_D30_HL_normalized,1,max, na.rm=T)

M05_D07_HL_normalized$max <- apply(M05_D07_HL_normalized,1,max, na.rm=T)
M05_D08_HL_normalized$max <- apply(M05_D08_HL_normalized,1,max, na.rm=T)
M05_D14_HL_normalized$max <- apply(M05_D14_HL_normalized,1,max, na.rm=T)
M05_D15_HL_normalized$max <- apply(M05_D15_HL_normalized,1,max, na.rm=T)
M05_D21_HL_normalized$max <- apply(M05_D21_HL_normalized,1,max, na.rm=T)
M05_D22_HL_normalized$max <- apply(M05_D22_HL_normalized,1,max, na.rm=T)

M05_D23_HL_normalized$max <- apply(M05_D23_HL_normalized,1,max, na.rm=T)
M05_D24_HL_normalized$max <- apply(M05_D24_HL_normalized,1,max, na.rm=T)
M05_D25_HL_normalized$max <- apply(M05_D25_HL_normalized,1,max, na.rm=T)
M05_D26_HL_normalized$max <- apply(M05_D26_HL_normalized,1,max, na.rm=T)
M05_D27_HL_normalized$max <- apply(M05_D27_HL_normalized,1,max, na.rm=T)

# Sets i and x values to run through 24 iterations.
i = 1
x = 24

while(i <= x)
{
  # Divides first column
  M05_D28_HL_normalized[,i] <- as.numeric(paste(M05_D28_HL_normalized[,i])) / as.numeric(as.character(M05_D28_HL_normalized$max))
  M05_D29_HL_normalized[,i] <- as.numeric(paste(M05_D29_HL_normalized[,i])) / as.numeric(as.character(M05_D29_HL_normalized$max))
  M05_D30_HL_normalized[,i] <- as.numeric(paste(M05_D30_HL_normalized[,i])) / as.numeric(as.character(M05_D30_HL_normalized$max))
  
  M05_D07_HL_normalized[,i] <- as.numeric(paste(M05_D07_HL_normalized[,i])) / as.numeric(as.character(M05_D07_HL_normalized$max))
  M05_D08_HL_normalized[,i] <- as.numeric(paste(M05_D08_HL_normalized[,i])) / as.numeric(as.character(M05_D08_HL_normalized$max))
  M05_D14_HL_normalized[,i] <- as.numeric(paste(M05_D14_HL_normalized[,i])) / as.numeric(as.character(M05_D14_HL_normalized$max))
  M05_D15_HL_normalized[,i] <- as.numeric(paste(M05_D15_HL_normalized[,i])) / as.numeric(as.character(M05_D15_HL_normalized$max))
  M05_D21_HL_normalized[,i] <- as.numeric(paste(M05_D21_HL_normalized[,i])) / as.numeric(as.character(M05_D21_HL_normalized$max))
  M05_D22_HL_normalized[,i] <- as.numeric(paste(M05_D22_HL_normalized[,i])) / as.numeric(as.character(M05_D22_HL_normalized$max))
  
  M05_D23_HL_normalized[,i] <- as.numeric(paste(M05_D23_HL_normalized[,i])) / as.numeric(as.character(M05_D23_HL_normalized$max))
  M05_D24_HL_normalized[,i] <- as.numeric(paste(M05_D24_HL_normalized[,i])) / as.numeric(as.character(M05_D24_HL_normalized$max))
  M05_D25_HL_normalized[,i] <- as.numeric(paste(M05_D25_HL_normalized[,i])) / as.numeric(as.character(M05_D25_HL_normalized$max))
  M05_D26_HL_normalized[,i] <- as.numeric(paste(M05_D26_HL_normalized[,i])) / as.numeric(as.character(M05_D26_HL_normalized$max))
  M05_D27_HL_normalized[,i] <- as.numeric(paste(M05_D27_HL_normalized[,i])) / as.numeric(as.character(M05_D27_HL_normalized$max))
  
  # Add 1 to i
  i = i + 1
}

# Removes the max column
M05_D28_HL_normalized$max <- NULL
M05_D29_HL_normalized$max <- NULL
M05_D30_HL_normalized$max <- NULL

M05_D07_HL_normalized$max <- NULL
M05_D08_HL_normalized$max <- NULL
M05_D14_HL_normalized$max <- NULL
M05_D15_HL_normalized$max <- NULL
M05_D21_HL_normalized$max <- NULL
M05_D22_HL_normalized$max <- NULL

M05_D23_HL_normalized$max <- NULL
M05_D24_HL_normalized$max <- NULL
M05_D25_HL_normalized$max <- NULL
M05_D26_HL_normalized$max <- NULL
M05_D27_HL_normalized$max <- NULL

# Creates array column, adds values, removes spaces, deletes 24 columns, puts brackets around array.
M05_D28_HL_normalized$twentyfourhours.n <- NA
M05_D28_HL_normalized$twentyfourhours.n <- apply(M05_D28_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D28_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D28_HL_normalized$twentyfourhours.n)
M05_D28_HL_normalized <- M05_D28_HL_normalized[ -c(1:24) ]
M05_D28_HL_normalized$twentyfourhours.n <- paste0("[",M05_D28_HL_normalized$twentyfourhours.n, "]")
M05_D29_HL_normalized$twentyfourhours.n <- NA
M05_D29_HL_normalized$twentyfourhours.n <- apply(M05_D29_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D29_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D29_HL_normalized$twentyfourhours.n)
M05_D29_HL_normalized <- M05_D29_HL_normalized[ -c(1:24) ]
M05_D29_HL_normalized$twentyfourhours.n <- paste0("[",M05_D29_HL_normalized$twentyfourhours.n, "]")
M05_D30_HL_normalized$twentyfourhours.n <- NA
M05_D30_HL_normalized$twentyfourhours.n <- apply(M05_D30_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D30_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D30_HL_normalized$twentyfourhours.n)
M05_D30_HL_normalized <- M05_D30_HL_normalized[ -c(1:24) ]
M05_D30_HL_normalized$twentyfourhours.n <- paste0("[",M05_D30_HL_normalized$twentyfourhours.n, "]")

M05_D07_HL_normalized$twentyfourhours.n <- NA
M05_D07_HL_normalized$twentyfourhours.n <- apply(M05_D07_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D07_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D07_HL_normalized$twentyfourhours.n)
M05_D07_HL_normalized <- M05_D07_HL_normalized[ -c(1:24) ]
M05_D07_HL_normalized$twentyfourhours.n <- paste0("[",M05_D07_HL_normalized$twentyfourhours.n, "]")
M05_D08_HL_normalized$twentyfourhours.n <- NA
M05_D08_HL_normalized$twentyfourhours.n <- apply(M05_D08_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D08_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D08_HL_normalized$twentyfourhours.n)
M05_D08_HL_normalized <- M05_D08_HL_normalized[ -c(1:24) ]
M05_D08_HL_normalized$twentyfourhours.n <- paste0("[",M05_D08_HL_normalized$twentyfourhours.n, "]")
M05_D14_HL_normalized$twentyfourhours.n <- NA
M05_D14_HL_normalized$twentyfourhours.n <- apply(M05_D14_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D14_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D14_HL_normalized$twentyfourhours.n)
M05_D14_HL_normalized <- M05_D14_HL_normalized[ -c(1:24) ]
M05_D14_HL_normalized$twentyfourhours.n <- paste0("[",M05_D14_HL_normalized$twentyfourhours.n, "]")
M05_D15_HL_normalized$twentyfourhours.n <- NA
M05_D15_HL_normalized$twentyfourhours.n <- apply(M05_D15_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D15_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D15_HL_normalized$twentyfourhours.n)
M05_D15_HL_normalized <- M05_D15_HL_normalized[ -c(1:24) ]
M05_D15_HL_normalized$twentyfourhours.n <- paste0("[",M05_D15_HL_normalized$twentyfourhours.n, "]")
M05_D21_HL_normalized$twentyfourhours.n <- NA
M05_D21_HL_normalized$twentyfourhours.n <- apply(M05_D21_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D21_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D21_HL_normalized$twentyfourhours.n)
M05_D21_HL_normalized <- M05_D21_HL_normalized[ -c(1:24) ]
M05_D21_HL_normalized$twentyfourhours.n <- paste0("[",M05_D21_HL_normalized$twentyfourhours.n, "]")
M05_D22_HL_normalized$twentyfourhours.n <- NA
M05_D22_HL_normalized$twentyfourhours.n <- apply(M05_D22_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D22_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D22_HL_normalized$twentyfourhours.n)
M05_D22_HL_normalized <- M05_D22_HL_normalized[ -c(1:24) ]
M05_D22_HL_normalized$twentyfourhours.n <- paste0("[",M05_D22_HL_normalized$twentyfourhours.n, "]")

M05_D23_HL_normalized$twentyfourhours.n <- NA
M05_D23_HL_normalized$twentyfourhours.n <- apply(M05_D23_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D23_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D23_HL_normalized$twentyfourhours.n)
M05_D23_HL_normalized <- M05_D23_HL_normalized[ -c(1:24) ]
M05_D23_HL_normalized$twentyfourhours.n <- paste0("[",M05_D23_HL_normalized$twentyfourhours.n, "]")
M05_D24_HL_normalized$twentyfourhours.n <- NA
M05_D24_HL_normalized$twentyfourhours.n <- apply(M05_D24_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D24_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D24_HL_normalized$twentyfourhours.n)
M05_D24_HL_normalized <- M05_D24_HL_normalized[ -c(1:24) ]
M05_D24_HL_normalized$twentyfourhours.n <- paste0("[",M05_D24_HL_normalized$twentyfourhours.n, "]")
M05_D25_HL_normalized$twentyfourhours.n <- NA
M05_D25_HL_normalized$twentyfourhours.n <- apply(M05_D25_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D25_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D25_HL_normalized$twentyfourhours)
M05_D25_HL_normalized <- M05_D25_HL_normalized[ -c(1:24) ]
M05_D25_HL_normalized$twentyfourhours.n <- paste0("[",M05_D25_HL_normalized$twentyfourhours.n, "]")
M05_D26_HL_normalized$twentyfourhours.n <- NA
M05_D26_HL_normalized$twentyfourhours.n <- apply(M05_D26_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D26_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D26_HL_normalized$twentyfourhours.n)
M05_D26_HL_normalized <- M05_D26_HL_normalized[ -c(1:24) ]
M05_D26_HL_normalized$twentyfourhours.n <- paste0("[",M05_D26_HL_normalized$twentyfourhours.n, "]")
M05_D27_HL_normalized$twentyfourhours.n <- NA
M05_D27_HL_normalized$twentyfourhours.n <- apply(M05_D27_HL_normalized[, 1:24], 1, paste, collapse=",")
M05_D27_HL_normalized$twentyfourhours.n <- gsub(" ", "", M05_D27_HL_normalized$twentyfourhours.n)
M05_D27_HL_normalized <- M05_D27_HL_normalized[ -c(1:24) ]
M05_D27_HL_normalized$twentyfourhours.n <- paste0("[",M05_D27_HL_normalized$twentyfourhours.n, "]")

# Creates array column, adds values, removes spaces, deletes 24 columns, puts brackets around array.
M05_D28_HL$twentyfourhours <- NA
M05_D28_HL$twentyfourhours <- apply(M05_D28_HL[, 1:24], 1, paste, collapse=",")
M05_D28_HL$twentyfourhours <- gsub(" ", "", M05_D28_HL$twentyfourhours)
M05_D28_HL <- M05_D28_HL[ -c(1:24) ]
M05_D28_HL$twentyfourhours <- paste0("[",M05_D28_HL$twentyfourhours, "]")
M05_D29_HL$twentyfourhours <- NA
M05_D29_HL$twentyfourhours <- apply(M05_D29_HL[, 1:24], 1, paste, collapse=",")
M05_D29_HL$twentyfourhours <- gsub(" ", "", M05_D29_HL$twentyfourhours)
M05_D29_HL <- M05_D29_HL[ -c(1:24) ]
M05_D29_HL$twentyfourhours <- paste0("[",M05_D29_HL$twentyfourhours, "]")
M05_D30_HL$twentyfourhours <- NA
M05_D30_HL$twentyfourhours <- apply(M05_D30_HL[, 1:24], 1, paste, collapse=",")
M05_D30_HL$twentyfourhours <- gsub(" ", "", M05_D30_HL$twentyfourhours)
M05_D30_HL <- M05_D30_HL[ -c(1:24) ]
M05_D30_HL$twentyfourhours <- paste0("[",M05_D30_HL$twentyfourhours, "]")

M05_D07_HL$twentyfourhours <- NA
M05_D07_HL$twentyfourhours <- apply(M05_D07_HL[, 1:24], 1, paste, collapse=",")
M05_D07_HL$twentyfourhours <- gsub(" ", "", M05_D07_HL$twentyfourhours)
M05_D07_HL <- M05_D07_HL[ -c(1:24) ]
M05_D07_HL$twentyfourhours <- paste0("[",M05_D07_HL$twentyfourhours, "]")
M05_D08_HL$twentyfourhours <- NA
M05_D08_HL$twentyfourhours <- apply(M05_D08_HL[, 1:24], 1, paste, collapse=",")
M05_D08_HL$twentyfourhours <- gsub(" ", "", M05_D08_HL$twentyfourhours)
M05_D08_HL <- M05_D08_HL[ -c(1:24) ]
M05_D08_HL$twentyfourhours <- paste0("[",M05_D08_HL$twentyfourhours, "]")
M05_D14_HL$twentyfourhours <- NA
M05_D14_HL$twentyfourhours <- apply(M05_D14_HL[, 1:24], 1, paste, collapse=",")
M05_D14_HL$twentyfourhours <- gsub(" ", "", M05_D14_HL$twentyfourhours)
M05_D14_HL <- M05_D14_HL[ -c(1:24) ]
M05_D14_HL$twentyfourhours <- paste0("[",M05_D14_HL$twentyfourhours, "]")
M05_D15_HL$twentyfourhours <- NA
M05_D15_HL$twentyfourhours <- apply(M05_D15_HL[, 1:24], 1, paste, collapse=",")
M05_D15_HL$twentyfourhours <- gsub(" ", "", M05_D15_HL$twentyfourhours)
M05_D15_HL <- M05_D15_HL[ -c(1:24) ]
M05_D15_HL$twentyfourhours <- paste0("[",M05_D15_HL$twentyfourhours, "]")
M05_D21_HL$twentyfourhours <- NA
M05_D21_HL$twentyfourhours <- apply(M05_D21_HL[, 1:24], 1, paste, collapse=",")
M05_D21_HL$twentyfourhours <- gsub(" ", "", M05_D21_HL$twentyfourhours)
M05_D21_HL <- M05_D21_HL[ -c(1:24) ]
M05_D21_HL$twentyfourhours <- paste0("[",M05_D21_HL$twentyfourhours, "]")
M05_D22_HL$twentyfourhours <- NA
M05_D22_HL$twentyfourhours <- apply(M05_D22_HL[, 1:24], 1, paste, collapse=",")
M05_D22_HL$twentyfourhours <- gsub(" ", "", M05_D22_HL$twentyfourhours)
M05_D22_HL <- M05_D22_HL[ -c(1:24) ]
M05_D22_HL$twentyfourhours <- paste0("[",M05_D22_HL$twentyfourhours, "]")

M05_D23_HL$twentyfourhours <- NA
M05_D23_HL$twentyfourhours <- apply(M05_D23_HL[, 1:24], 1, paste, collapse=",")
M05_D23_HL$twentyfourhours <- gsub(" ", "", M05_D23_HL$twentyfourhours)
M05_D23_HL <- M05_D23_HL[ -c(1:24) ]
M05_D23_HL$twentyfourhours <- paste0("[",M05_D23_HL$twentyfourhours, "]")
M05_D24_HL$twentyfourhours <- NA
M05_D24_HL$twentyfourhours <- apply(M05_D24_HL[, 1:24], 1, paste, collapse=",")
M05_D24_HL$twentyfourhours <- gsub(" ", "", M05_D24_HL$twentyfourhours)
M05_D24_HL <- M05_D24_HL[ -c(1:24) ]
M05_D24_HL$twentyfourhours <- paste0("[",M05_D24_HL$twentyfourhours, "]")
M05_D25_HL$twentyfourhours <- NA
M05_D25_HL$twentyfourhours <- apply(M05_D25_HL[, 1:24], 1, paste, collapse=",")
M05_D25_HL$twentyfourhours <- gsub(" ", "", M05_D25_HL$twentyfourhours)
M05_D25_HL <- M05_D25_HL[ -c(1:24) ]
M05_D25_HL$twentyfourhours <- paste0("[",M05_D25_HL$twentyfourhours, "]")
M05_D26_HL$twentyfourhours <- NA
M05_D26_HL$twentyfourhours <- apply(M05_D26_HL[, 1:24], 1, paste, collapse=",")
M05_D26_HL$twentyfourhours <- gsub(" ", "", M05_D26_HL$twentyfourhours)
M05_D26_HL <- M05_D26_HL[ -c(1:24) ]
M05_D26_HL$twentyfourhours <- paste0("[",M05_D26_HL$twentyfourhours, "]")
M05_D27_HL$twentyfourhours <- NA
M05_D27_HL$twentyfourhours <- apply(M05_D27_HL[, 1:24], 1, paste, collapse=",")
M05_D27_HL$twentyfourhours <- gsub(" ", "", M05_D27_HL$twentyfourhours)
M05_D27_HL <- M05_D27_HL[ -c(1:24) ]
M05_D27_HL$twentyfourhours <- paste0("[",M05_D27_HL$twentyfourhours, "]")

# Merges the normalized dataframes with the un-normalized dataframes.
M05_D28_HL <- merge(M05_D28_HL, M05_D28_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D29_HL <- merge(M05_D29_HL, M05_D29_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D30_HL <- merge(M05_D30_HL, M05_D30_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)

M05_D07_HL <- merge(M05_D07_HL, M05_D07_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D08_HL <- merge(M05_D08_HL, M05_D08_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D14_HL <- merge(M05_D14_HL, M05_D14_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D15_HL <- merge(M05_D15_HL, M05_D15_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D21_HL <- merge(M05_D21_HL, M05_D21_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D22_HL <- merge(M05_D22_HL, M05_D22_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)

M05_D23_HL <- merge(M05_D23_HL, M05_D23_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D24_HL <- merge(M05_D24_HL, M05_D24_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D25_HL <- merge(M05_D25_HL, M05_D25_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D26_HL <- merge(M05_D26_HL, M05_D26_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)
M05_D27_HL <- merge(M05_D27_HL, M05_D27_HL_normalized, by.x = "row.names", by.y = "row.names", all.x = T)

# Merges the travel sensors dataframe which contains the latitude and longitude.
M05_D28_HL <- merge(M05_D28_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D29_HL <- merge(M05_D29_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D30_HL <- merge(M05_D30_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)

M05_D07_HL <- merge(M05_D07_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D08_HL <- merge(M05_D08_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D14_HL <- merge(M05_D14_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D15_HL <- merge(M05_D15_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D21_HL <- merge(M05_D21_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D22_HL <- merge(M05_D22_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)

M05_D23_HL <- merge(M05_D23_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D24_HL <- merge(M05_D24_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D25_HL <- merge(M05_D25_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D26_HL <- merge(M05_D26_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)
M05_D27_HL <- merge(M05_D27_HL, TravelSensors, by.x = "Row.names", by.y = "READER_ID", all.x = T)

# Rename the first column from "Row.names"
colnames(M05_D28_HL)[1] <- "Reader_ID"
colnames(M05_D29_HL)[1] <- "Reader_ID"
colnames(M05_D30_HL)[1] <- "Reader_ID"

colnames(M05_D07_HL)[1] <- "Reader_ID"
colnames(M05_D08_HL)[1] <- "Reader_ID"
colnames(M05_D14_HL)[1] <- "Reader_ID"
colnames(M05_D15_HL)[1] <- "Reader_ID"
colnames(M05_D21_HL)[1] <- "Reader_ID"
colnames(M05_D22_HL)[1] <- "Reader_ID"

colnames(M05_D23_HL)[1] <- "Reader_ID"
colnames(M05_D24_HL)[1] <- "Reader_ID"
colnames(M05_D25_HL)[1] <- "Reader_ID"
colnames(M05_D26_HL)[1] <- "Reader_ID"
colnames(M05_D27_HL)[1] <- "Reader_ID"

# Keep only the desired columns.
M05_D28_HL <- M05_D28_HL[c(1,2,3,31,32)]
M05_D29_HL <- M05_D29_HL[c(1,2,3,31,32)]
M05_D30_HL <- M05_D30_HL[c(1,2,3,31,32)]

M05_D07_HL <- M05_D07_HL[c(1,2,3,31,32)]
M05_D08_HL <- M05_D08_HL[c(1,2,3,31,32)]
M05_D14_HL <- M05_D14_HL[c(1,2,3,31,32)]
M05_D15_HL <- M05_D15_HL[c(1,2,3,31,32)]
M05_D21_HL <- M05_D21_HL[c(1,2,3,31,32)]
M05_D22_HL <- M05_D22_HL[c(1,2,3,31,32)]

M05_D23_HL <- M05_D23_HL[c(1,2,3,31,32)]
M05_D24_HL <- M05_D24_HL[c(1,2,3,31,32)]
M05_D25_HL <- M05_D25_HL[c(1,2,3,31,32)]
M05_D26_HL <- M05_D26_HL[c(1,2,3,31,32)]
M05_D27_HL <- M05_D27_HL[c(1,2,3,31,32)]

# Adds Longitude and Latitude values that were missed due to naming discrepancies.
M05_D28_HL$LOCATION_LATITUDE[M05_D28_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D28_HL$LOCATION_LONGITUDE[M05_D28_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D28_HL$LOCATION_LATITUDE[M05_D28_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D28_HL$LOCATION_LONGITUDE[M05_D28_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D28_HL$LOCATION_LATITUDE[M05_D28_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D28_HL$LOCATION_LONGITUDE[M05_D28_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D28_HL$LOCATION_LATITUDE[M05_D28_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D28_HL$LOCATION_LONGITUDE[M05_D28_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D28_HL$LOCATION_LATITUDE[M05_D28_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D28_HL$LOCATION_LONGITUDE[M05_D28_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D29_HL$LOCATION_LATITUDE[M05_D29_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D29_HL$LOCATION_LONGITUDE[M05_D29_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D29_HL$LOCATION_LATITUDE[M05_D29_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D29_HL$LOCATION_LONGITUDE[M05_D29_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D29_HL$LOCATION_LATITUDE[M05_D29_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D29_HL$LOCATION_LONGITUDE[M05_D29_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D29_HL$LOCATION_LATITUDE[M05_D29_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D29_HL$LOCATION_LONGITUDE[M05_D29_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D29_HL$LOCATION_LATITUDE[M05_D29_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D29_HL$LOCATION_LONGITUDE[M05_D29_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D30_HL$LOCATION_LATITUDE[M05_D30_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D30_HL$LOCATION_LONGITUDE[M05_D30_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D30_HL$LOCATION_LATITUDE[M05_D30_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D30_HL$LOCATION_LONGITUDE[M05_D30_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D30_HL$LOCATION_LATITUDE[M05_D30_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D30_HL$LOCATION_LONGITUDE[M05_D30_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D30_HL$LOCATION_LATITUDE[M05_D30_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D30_HL$LOCATION_LONGITUDE[M05_D30_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D30_HL$LOCATION_LATITUDE[M05_D30_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D30_HL$LOCATION_LONGITUDE[M05_D30_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]

M05_D07_HL$LOCATION_LATITUDE[M05_D07_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D07_HL$LOCATION_LONGITUDE[M05_D07_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D07_HL$LOCATION_LATITUDE[M05_D07_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D07_HL$LOCATION_LONGITUDE[M05_D07_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D07_HL$LOCATION_LATITUDE[M05_D07_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D07_HL$LOCATION_LONGITUDE[M05_D07_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D07_HL$LOCATION_LATITUDE[M05_D07_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D07_HL$LOCATION_LONGITUDE[M05_D07_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D07_HL$LOCATION_LATITUDE[M05_D07_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D07_HL$LOCATION_LONGITUDE[M05_D07_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D08_HL$LOCATION_LATITUDE[M05_D08_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D08_HL$LOCATION_LONGITUDE[M05_D08_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D08_HL$LOCATION_LATITUDE[M05_D08_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D08_HL$LOCATION_LONGITUDE[M05_D08_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D08_HL$LOCATION_LATITUDE[M05_D08_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D08_HL$LOCATION_LONGITUDE[M05_D08_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D08_HL$LOCATION_LATITUDE[M05_D08_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D08_HL$LOCATION_LONGITUDE[M05_D08_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D08_HL$LOCATION_LATITUDE[M05_D08_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D08_HL$LOCATION_LONGITUDE[M05_D08_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D14_HL$LOCATION_LATITUDE[M05_D14_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D14_HL$LOCATION_LONGITUDE[M05_D14_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D14_HL$LOCATION_LATITUDE[M05_D14_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D14_HL$LOCATION_LONGITUDE[M05_D14_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D14_HL$LOCATION_LATITUDE[M05_D14_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D14_HL$LOCATION_LONGITUDE[M05_D14_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D14_HL$LOCATION_LATITUDE[M05_D14_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D14_HL$LOCATION_LONGITUDE[M05_D14_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D14_HL$LOCATION_LATITUDE[M05_D14_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D14_HL$LOCATION_LONGITUDE[M05_D14_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D15_HL$LOCATION_LATITUDE[M05_D15_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D15_HL$LOCATION_LONGITUDE[M05_D15_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D15_HL$LOCATION_LATITUDE[M05_D15_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D15_HL$LOCATION_LONGITUDE[M05_D15_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D15_HL$LOCATION_LATITUDE[M05_D15_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D15_HL$LOCATION_LONGITUDE[M05_D15_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D15_HL$LOCATION_LATITUDE[M05_D15_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D15_HL$LOCATION_LONGITUDE[M05_D15_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D15_HL$LOCATION_LATITUDE[M05_D15_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D15_HL$LOCATION_LONGITUDE[M05_D15_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D21_HL$LOCATION_LATITUDE[M05_D21_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D21_HL$LOCATION_LONGITUDE[M05_D21_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D21_HL$LOCATION_LATITUDE[M05_D21_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D21_HL$LOCATION_LONGITUDE[M05_D21_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D21_HL$LOCATION_LATITUDE[M05_D21_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D21_HL$LOCATION_LONGITUDE[M05_D21_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D21_HL$LOCATION_LATITUDE[M05_D21_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D21_HL$LOCATION_LONGITUDE[M05_D21_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D21_HL$LOCATION_LATITUDE[M05_D21_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D21_HL$LOCATION_LONGITUDE[M05_D21_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D22_HL$LOCATION_LATITUDE[M05_D22_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D22_HL$LOCATION_LONGITUDE[M05_D22_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D22_HL$LOCATION_LATITUDE[M05_D22_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D22_HL$LOCATION_LONGITUDE[M05_D22_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D22_HL$LOCATION_LATITUDE[M05_D22_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D22_HL$LOCATION_LONGITUDE[M05_D22_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D22_HL$LOCATION_LATITUDE[M05_D22_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D22_HL$LOCATION_LONGITUDE[M05_D22_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D22_HL$LOCATION_LATITUDE[M05_D22_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D22_HL$LOCATION_LONGITUDE[M05_D22_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]

M05_D23_HL$LOCATION_LATITUDE[M05_D23_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D23_HL$LOCATION_LONGITUDE[M05_D23_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D23_HL$LOCATION_LATITUDE[M05_D23_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D23_HL$LOCATION_LONGITUDE[M05_D23_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D23_HL$LOCATION_LATITUDE[M05_D23_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D23_HL$LOCATION_LONGITUDE[M05_D23_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D23_HL$LOCATION_LATITUDE[M05_D23_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D23_HL$LOCATION_LONGITUDE[M05_D23_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D23_HL$LOCATION_LATITUDE[M05_D23_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D23_HL$LOCATION_LONGITUDE[M05_D23_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D24_HL$LOCATION_LATITUDE[M05_D24_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D24_HL$LOCATION_LONGITUDE[M05_D24_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D24_HL$LOCATION_LATITUDE[M05_D24_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D24_HL$LOCATION_LONGITUDE[M05_D24_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D24_HL$LOCATION_LATITUDE[M05_D24_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D24_HL$LOCATION_LONGITUDE[M05_D24_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D24_HL$LOCATION_LATITUDE[M05_D24_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D24_HL$LOCATION_LONGITUDE[M05_D24_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D24_HL$LOCATION_LATITUDE[M05_D24_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D24_HL$LOCATION_LONGITUDE[M05_D24_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D25_HL$LOCATION_LATITUDE[M05_D25_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D25_HL$LOCATION_LONGITUDE[M05_D25_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D25_HL$LOCATION_LATITUDE[M05_D25_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D25_HL$LOCATION_LONGITUDE[M05_D25_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D25_HL$LOCATION_LATITUDE[M05_D25_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D25_HL$LOCATION_LONGITUDE[M05_D25_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D25_HL$LOCATION_LATITUDE[M05_D25_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D25_HL$LOCATION_LONGITUDE[M05_D25_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D25_HL$LOCATION_LATITUDE[M05_D25_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D25_HL$LOCATION_LONGITUDE[M05_D25_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D26_HL$LOCATION_LATITUDE[M05_D26_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D26_HL$LOCATION_LONGITUDE[M05_D26_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D26_HL$LOCATION_LATITUDE[M05_D26_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D26_HL$LOCATION_LONGITUDE[M05_D26_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D26_HL$LOCATION_LATITUDE[M05_D26_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D26_HL$LOCATION_LONGITUDE[M05_D26_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D26_HL$LOCATION_LATITUDE[M05_D26_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D26_HL$LOCATION_LONGITUDE[M05_D26_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D26_HL$LOCATION_LATITUDE[M05_D26_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D26_HL$LOCATION_LONGITUDE[M05_D26_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D27_HL$LOCATION_LATITUDE[M05_D27_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D27_HL$LOCATION_LONGITUDE[M05_D27_HL$Reader_ID=="benWhite_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="benwhite_riverside"]
M05_D27_HL$LOCATION_LATITUDE[M05_D27_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D27_HL$LOCATION_LONGITUDE[M05_D27_HL$Reader_ID=="ih_35_riverside"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="riverside_ih35"]
M05_D27_HL$LOCATION_LATITUDE[M05_D27_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D27_HL$LOCATION_LONGITUDE[M05_D27_HL$Reader_ID=="cesar_chavez_ih_35"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="cesar_chavez_ih35"]
M05_D27_HL$LOCATION_LATITUDE[M05_D27_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D27_HL$LOCATION_LONGITUDE[M05_D27_HL$Reader_ID=="fm_2222_loop360"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="fm2222_loop360"]
M05_D27_HL$LOCATION_LATITUDE[M05_D27_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LATITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]
M05_D27_HL$LOCATION_LONGITUDE[M05_D27_HL$Reader_ID=="lamar_brodie_oak"] <- TravelSensors$LOCATION_LONGITUDE[TravelSensors$READER_ID=="Lamar_BrodieOaks"]

# Writes the files to a CSV.
write.csv(M05_D28_HL, "M05_D28_HL.csv")
write.csv(M05_D29_HL, "M05_D29_HL.csv")
write.csv(M05_D30_HL, "M05_D30_HL.csv")

write.csv(M05_D07_HL, "M05_D07_HL.csv")
write.csv(M05_D08_HL, "M05_D08_HL.csv")
write.csv(M05_D14_HL, "M05_D14_HL.csv")
write.csv(M05_D15_HL, "M05_D15_HL.csv")
write.csv(M05_D21_HL, "M05_D21_HL.csv")
write.csv(M05_D22_HL, "M05_D22_HL.csv")

write.csv(M05_D23_HL, "M05_D23_HL.csv")
write.csv(M05_D24_HL, "M05_D24_HL.csv")
write.csv(M05_D25_HL, "M05_D25_HL.csv")
write.csv(M05_D26_HL, "M05_D26_HL.csv")
write.csv(M05_D27_HL, "M05_D27_HL.csv")

