# Select dates in question from the data set
library(sqldf)
fi <- file("household_power_consumption.txt")
powerdata <- read.csv.sql(sql = "SELECT * from fi WHERE Date in ('1/2/2007','2/2/2007')", sep = ";", header = TRUE)
close(fi)
# Create date/time column
powerdata$dt <- paste(powerdata$Date, powerdata$Time)
# convert new column to date and time values
powerdata$dt <- strptime(powerdata$dt, format = "%d/%m/%Y %H:%M:%S")
#Draw four plots
png(filename = "plot4.png")
par(mfcol = c(2, 2))
        plot(powerdata$dt, powerdata$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
        plot(powerdata$dt, powerdata$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
        lines(powerdata$dt, powerdata$Sub_metering_1, type = "l", col = "black")
        lines(powerdata$dt, powerdata$Sub_metering_2, type = "l", col = "red")
        lines(powerdata$dt, powerdata$Sub_metering_3, type = "l", col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), bty="n",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(powerdata$dt, powerdata$Voltage, type = "l", xlab="datetime")
plot(powerdata$dt, powerdata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()

