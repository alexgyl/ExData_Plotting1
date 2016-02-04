## Plot 2 construction
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

## Creating a date time variable for plotting
sub$DateTime = paste(sub$Date,sub$Time) 
sub$DateTime = ymd_hms(sub$DateTime)

## Plotting of line graph with date
png(filename = "plot2.png",width = 480,height = 480)
plot(y = sub$Global_active_power,x = sub$DateTime,type = "n",ylab = "Global Active Power (kilowatts)", xlab = "")
lines(x = sub$DateTime,y = sub$Global_active_power)
dev.off()
