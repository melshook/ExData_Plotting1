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

png(file="plot1.png", height=480, width=480)

##Step 3: set the parameters for one plot 

par(mfrow=c(1,1))

##Step 3: create the plot

hist(as.numeric(pData$Global_active_power), col="red", main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab= "Frequency", xaxt='n')
axis(side=1, at=seq(0,3000,1000), labels= seq(0,6,2))

##Step 4: turn off the device
dev.off()

##Step 5: just for fun, print "File created"
print("File created")