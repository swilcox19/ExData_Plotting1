# data from "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# read data
power <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", as.is = TRUE, nrows = 69600)
# convert dates and times from character to date/time format
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power$Time <- strptime(power$Time, "%H:%M:%S")
# update y/M/D to match up with test$Date column
library(lubridate)
power$Time <- update(power$Time, year = year(power$Date), month = month(power$Date), day = day(power$Date))
# subset to get only rows for February 1, 2007 and February 2, 2007
power_subset <- power[power$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]
# convert characters to numeric as needed
power_subset$Global_active_power <- as.numeric(power_subset$Global_active_power)
power_subset$Global_reactive_power <- as.numeric(power_subset$Global_reactive_power)
power_subset$Voltage <- as.numeric(power_subset$Voltage)
power_subset$Global_intensity <- as.numeric(power_subset$Global_intensity)
power_subset$Sub_metering_1 <- as.numeric(power_subset$Sub_metering_1)
power_subset$Sub_metering_2 <- as.numeric(power_subset$Sub_metering_2)
# Sub_metering_3 was originally read in as numeric
######################################################################
# make plot
with(power_subset, plot(Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", pch = NA))
with(power_subset,lines(Time, Sub_metering_1))
with(power_subset, points(Time, Sub_metering_2, pch = NA))
with(power_subset,lines(Time, Sub_metering_2, col = "red"))
with(power_subset,lines(Time, Sub_metering_3, col = "blue"))
with(power_subset, points(Time, Sub_metering_3, pch = NA))
legend("topright", lty = 1, cex = 0.7, pch = NA, col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# need to tighten up legend
#####################################################################
# copy plot to png file
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()