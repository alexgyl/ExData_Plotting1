## Plot 1 construction
## Data ingestion and libraries
library(lubridate)
library(dplyr)
data = read.table("household_power_consumption.txt",sep = ";",header = TRUE,stringsAsFactors = FALSE)

## Converting to date format
data$Date = dmy(data$Date)

## Converting to dplyr table format
data = tbl_df(data)
sub = filter(data,(Date == ymd("2007-02-01")) | (Date == ymd("2007-02-02")))

## Data cleaning for variable
sub$Global_active_power = as.numeric(sub$Global_active_power)

## Histogram for plot 1
hist(sub$Global_active_power,main = "Global Active Power",col = "red",xlab = "Global Active Power (kilowatts)",ylab = "Frequency")
## Copying plot to png file
dev.copy(png,file = "plot1.png")
dev.off()
