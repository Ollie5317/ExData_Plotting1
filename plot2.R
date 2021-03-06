### Script to produce plot 2

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
png("plot2.png", width=480, height=480)

# Produce line graph of Global Active Power
plot(data1$Global_active_power~data1$DateTime, type = "l", ylab="Global Active Power (kilowatts)", xlab ="")

# Close graphics window
dev.off()