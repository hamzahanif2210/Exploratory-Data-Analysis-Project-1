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
png(filename = './figs/plot2.png', width = 480, height = 480, units='px')

#plot 
plot(data$Global_active_power~data$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()
