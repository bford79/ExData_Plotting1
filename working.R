#Create the trimmed down database

#read in full file
epc.full <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                       na.strings = "?", colClasses = c("character", "character", 
                       "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",
                       "numeric"))

#combine Date and Time columns and set format to POSIXlt
Date.Time <- data.frame("Date.Time" = paste(epc.full$Date, epc.full$Time, sep = " "))
epc.full <- cbind(Date.Time, epc.full)
epc.full$Date <- NULL
epc.full$Time <- NULL
epc.full$Date.Time <- strptime(epc.full$Date.Time, format = "%d/%m/%Y %H:%M:%S")

#subset data frame for the two dates we need
epc.feb <- subset(epc.full, Date.Time >= as.POSIXlt("2007-02-01 00:00:00 CST") & 
                       Date.Time <= as.POSIXlt("2007-02-02 23:59:59 CST"))

#create plot1

png(file = "plot1.png", width = 480, height = 480)
hist(epc.feb$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", ylim = c(0,1200), main = "Global Active Power")
dev.off()

#create plot2

png(file = "plot2.png", width = 480, height = 480)
plot(epc.feb$Date.Time, epc.feb$Global_active_power, type = "l", xlab = "", ylab = 
          "Global Active Power (kilowatts)")
dev.off()

#create plot3

png(file = "plot3.png", width = 480, height = 480)
plot(epc.feb$Date.Time, epc.feb$Sub_metering_1, type = "l", ylab = "Energy sub metering",
     xlab = "")
lines(epc.feb$Date.Time, epc.feb$Sub_metering_2, col = "red", type="l")
lines(epc.feb$Date.Time, epc.feb$Sub_metering_3, col = "blue", type="l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), 
       col = c("black", "red", "blue"))
dev.off()

#create plot4

png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(epc.feb$Date.Time, epc.feb$Global_active_power, type = "l", xlab = "", ylab = 
          "Global Active Power (kilowatts)")
plot(epc.feb$Date.Time, epc.feb$Voltage, type = "l", xlab = "datetime", ylab = 
          "Voltage")
plot(epc.feb$Date.Time, epc.feb$Sub_metering_1, type = "l", ylab = "Energy sub metering",
     xlab = "")
lines(epc.feb$Date.Time, epc.feb$Sub_metering_2, col = "red", type="l")
lines(epc.feb$Date.Time, epc.feb$Sub_metering_3, col = "blue", type="l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), 
       col = c("black", "red", "blue"), bty = "n")
plot(epc.feb$Date.Time, epc.feb$Global_reactive_power, type = "l", xlab = "datetime")
dev.off()