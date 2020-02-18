### Script to produce plot 4

## load library
library(dplyr)

## Extract and format data 
# Extract file from zip file
filename <- "exdata_data_household_power_consumption.zip"
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

# Read file into R
data <- read.table("household_power_consumption.txt", na.strings = "?", skip = 1, sep = ";", stringsAsFactors=F,  
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                                 "Voltage", "Global_intensity","Sub_metering_1", "Sub_metering_2", 
                                 "Sub_metering_3"))

# Convert date columns to date class
data$Date <- as.Date(data$Date, format='%d/%m/%Y')

# Subset data for required dates 
data1 <- filter(data, Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))

# Combine the date and time variables into one variable 
datetime <- paste(data1$Date, data1$Time)

# Convert datetime into data/time class and add to table 
data1$DateTime <- as.POSIXct(datetime)

# Open a PNG graphics window to save plot into 
png("plot4.png", width=480, height=480)

# Split plotting area up into 4 graphs
par(mfrow = c(2, 2))

# Plot graph 1
plot(data1$Global_active_power~data1$DateTime, type = "l", ylab="Global Active Power", xlab ="")

# Plot graph 2
plot(data1$Voltage~data1$DateTime, type = "l", ylab = "Voltage", xlab = "datetime")

# Plot graph 3
plot(data1$Sub_metering_1~data1$DateTime, type = "l", ylab="Energy sub meeting", xlab ="")
lines(data1$Sub_metering_2~data1$DateTime, col="red")
lines(data1$Sub_metering_3~data1$DateTime, col="blue")

legend("topright", col = c("black", "blue", "red"), bty= "n", lty = 1, lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot graph 4
plot(data1$Global_reactive_power~data1$DateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

# Close graphics window
dev.off()




