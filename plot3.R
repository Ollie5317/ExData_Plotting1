### Script to produce plot 3

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
png("plot3.png", width=480, height=480)

# Produce 3 line graphs of the sub meter reading on what graph
plot(data1$Sub_metering_1~data1$DateTime, type = "l", ylab="Energy sub meeting", xlab ="")
lines(data1$Sub_metering_2~data1$DateTime, col="red")
lines(data1$Sub_metering_3~data1$DateTime, col="blue")

legend("topright", col = c("black", "blue", "red"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close graphics window
dev.off()




