# Select dates in question from the data set
library(sqldf)
fi <- file("household_power_consumption.txt")
powerdata <- read.csv.sql(sql = "SELECT * from fi WHERE Date in ('1/2/2007','2/2/2007')", sep = ";", header = TRUE)
close(fi)
# Create date/time column
powerdata$dt <- paste(powerdata$Date, powerdata$Time)
# convert new column to date and time values
powerdata$dt <- strptime(powerdata$dt, format = "%d/%m/%Y %H:%M:%S")
attach(powerdata)

# Create histogram
png(filename = "plot1.png")
hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()