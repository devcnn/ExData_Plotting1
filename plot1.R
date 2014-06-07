temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
theData <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",header=TRUE,stringsAsFactors=FALSE)
unlink(temp)

#theData <- read.table("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors=FALSE)


theData$DateTime <- strptime(paste(theData$Date, theData$Time),format="%d/%m/%Y %H:%M:%S")


theData$Date <- strptime((theData$Date),format="%d/%m/%Y")

theData$Date <- as.Date(theData$Date)


data <- theData[((theData$Date >= "2007-02-01")&(theData$Date <= "2007-02-02")),]

data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1   <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2   <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3   <- as.numeric(data$Sub_metering_3)

png("plot1.png",bg="transparent",width=480,height=480)

hist(data$Global_active_power,col="red",main="Global Active Power",labels = FALSE, xlab="Global Active Power (kilowatts)")

dev.off()



