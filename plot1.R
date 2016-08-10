# 1. Prepare data
if (!exists("myData")) {
  
  # 1.1. Read raw data
  myData <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", as.is=TRUE)
    
  # 1.2. Convert first variable to date
  myData$Date <- as.Date(myData$Date, format = "%d/%m/%Y")
  
  # 1.3. Get data only for the dates between 2007-02-01 and 2007-02-02
  myData <- subset(myData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
  
  # 1.4. Convert second column to Date/Time
  dateTimeString <- paste( format(myData$Date, "%Y-%m-%d"), myData$Time )
  myData$Time <- strptime( dateTimeString, format = "%Y-%m-%d %H:%M:%S" )
}

# 2. Build a graph
hist(myData$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

# 3. Save it to a PNG
dev.copy(png, file="plot1.png", height = 480, width = 480)
dev.off()