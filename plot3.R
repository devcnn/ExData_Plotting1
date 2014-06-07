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

max <- max(max(data$Sub_metering_1),max(data$Sub_metering_2),max(data$Sub_metering_3))

png("plot3.png",bg="transparent",width=480,height=480)

plot(data$DateTime,data$Global_active_power,yaxt="n",ylim=c(0,max),ylab="Energy sub metering",xlab="",type="n")
ticks<- c(0,10,20,30)
axis(2,at=ticks,labels=ticks)

lines(data$DateTime,data$Sub_metering_1,col="black")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")

legend(x = "topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1, 1, 1), lwd=c(2.5, 2.5, 2.5), col=c("black", "red", "blue") )

dev.off()

