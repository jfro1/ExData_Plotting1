# Select dates in question from the data set
library(sqldf)
fi <- file("household_power_consumption.txt")
powerdata <- read.csv.sql(sql = "SELECT * from fi WHERE Date in ('1/2/2007','2/2/2007')", sep = ";", header = TRUE)
close(fi)
# Create date/time column
powerdata$dt <- paste(powerdata$Date, powerdata$Time)
# convert new column to date and time values
powerdata$dt <- strptime(powerdata$dt, format = "%d/%m/%Y %H:%M:%S")
# Create Plot
png(filename = "plot3.png")     
        plot(powerdata$dt, powerdata$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
        lines(powerdata$dt, powerdata$Sub_metering_1, type = "l", col = "black")
        lines(powerdata$dt, powerdata$Sub_metering_2, type = "l", col = "red")
        lines(powerdata$dt, powerdata$Sub_metering_3, type = "l", col = "blue")
        legend("topright", lty = c(1,1,1), cex=1, pt.cex = cex, xjust = 1, yjust = 1, adj = c(0, 0.5), 
               lwd = c(2.5, 2.5, 2.5), col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

