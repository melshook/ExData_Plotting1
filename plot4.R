##This script will load power consumption data, create a plot, and write the plot to a png file.
##Step 1: read in the data from the household_power_consumption.txt file. This file should be in
##your working directory in order for this script to work.

powerData <- read.table("household_power_consumption.txt", header=TRUE, sep=';')
#create a new variable "datetime" in the dataframe
powerData$datetime <- dmy_hms(paste(powerData$Date, powerData$Time))
#convert the Date field to a Date to make it easier to subset
powerData$Date <- as.Date(dmy(powerData$Date))
#subset the data to only the dates of 2-01-2007 and 2-02-2007
pData <- powerData[which(powerData$Date=='2007-02-01'| powerData$Date=='2007-02-02'),]

##Step 2: set up the png device

png(file="plot4.png", height=480, width=480)

##Step 3: set the parameters for four plots 

par(mfrow=c(2,2))

##Step 3: create the plots
#1
plot(pData$datetime, pData$Global_active_power, xlab="", ylab="Global active power", type='l')

#2
plot(pData$datetime, pData$Voltage, xlab="datetime", ylab="Voltage", type='l')
#3
plot(pData$datetime, pData$Sub_metering_1, type='n', ylab= "Energy sub metering", xlab="")
lines(pData$datetime, pData$Sub_metering_1, ylim=c(0,30))
lines(pData$datetime, pData$Sub_metering_2, col="red")
lines(pData$datetime, pData$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, cex=.3)
#4
plot(pData$datetime, pData$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", 
     type='l', yaxt='n', ylim=c(0,250))
axis(side=2, at=seq(0,250,50), labels=seq(0,.5,.1))


##Step 4: turn off the device
dev.off()

##Step 5: just for fun, print "File created"
print("File created")