## Plot 3 construction
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
sub$Sub_metering_1 = as.numeric(sub$Sub_metering_1)
sub$Sub_metering_2 = as.numeric(sub$Sub_metering_2)
sub$Sub_metering_3 = as.numeric(sub$Sub_metering_3)

## Creating a date time variable for plotting
sub$DateTime = paste(sub$Date,sub$Time) 
sub$DateTime = ymd_hms(sub$DateTime)

## Plotting of line graph with datetime and colors
plot(x = sub$DateTime, y= sub$Sub_metering_1,type = "n",ylab = "Energy sub metering", xlab = "")
lines(x = sub$DateTime,y = sub$Sub_metering_1,col = "black")
lines(x = sub$DateTime,y = sub$Sub_metering_2,col = "red")
lines(x = sub$DateTime,y = sub$Sub_metering_3,col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1,cex = 0.7)

dev.copy(png,file = "plot3.png")
dev.off()
