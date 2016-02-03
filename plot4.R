## Plot 4 construction
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
sub$Voltage = as.numeric(sub$Voltage)
sub$Global_reactive_power = as.numeric(sub$Global_reactive_power)
## Creating a date time variable for plotting
sub$DateTime = paste(sub$Date,sub$Time) 
sub$DateTime = ymd_hms(sub$DateTime)

## Plotting all 4 plots
par(mfrow = c(2,2),mar = c(5,2,2,1))
## Rows fill up row-wise
## Plot 1
plot(y = sub$Global_active_power,x = sub$DateTime,type = "n",ylab = "Global Active Power", xlab = "")
lines(x = sub$DateTime,y = sub$Global_active_power)
## Plot 2
plot(y = sub$Voltage,x = sub$DateTime,type = "n",ylab = "Voltage", xlab = "datetime")
lines(x = sub$DateTime,y = sub$Voltage)
## Plot 3
plot(x = sub$DateTime, y= sub$Sub_metering_1,type = "n",ylab = "Energy sub metering", xlab = "")
lines(x = sub$DateTime,y = sub$Sub_metering_1,col = "black")
lines(x = sub$DateTime,y = sub$Sub_metering_2,col = "red")
lines(x = sub$DateTime,y = sub$Sub_metering_3,col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1,cex = 0.5,bty = "n")

## Plot 4
plot(y = sub$Global_reactive_power,x = sub$DateTime,type = "n", xlab = "datetime",ylab = "Global_reactive_power")
lines(x = sub$DateTime,y = sub$Global_reactive_power)

dev.copy(png,file = "plot4.png")
dev.off()

