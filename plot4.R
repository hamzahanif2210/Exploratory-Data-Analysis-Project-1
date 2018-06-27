data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Change date to Type Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Filter data set
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Remove incomplete observation
data <- data[complete.cases(data),]

# merge date and time column
dateTime <- paste(data$Date, data$Time)


dateTime <- setNames(dateTime, "DateTime")

# remove Date and Time column
data <- data[ ,!(names(data) %in% c("Date","Time"))]

# add DateTime column
data <- cbind(dateTime, data)

# Format dateTime Column
data$dateTime <- as.POSIXct(dateTime)

if(!file.exists('figs')) dir.create('figs')
png(filename = './figs/plot4.png', width = 480, height = 480, units='px')

#plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.off()