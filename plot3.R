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


#create plot3

png(file = "plot3.png", width = 480, height = 480)
plot(epc.feb$Date.Time, epc.feb$Sub_metering_1, type = "l", ylab = "Energy sub metering",
     xlab = "")
lines(epc.feb$Date.Time, epc.feb$Sub_metering_2, col = "red", type="l")
lines(epc.feb$Date.Time, epc.feb$Sub_metering_3, col = "blue", type="l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), 
       col = c("black", "red", "blue"))
dev.off()