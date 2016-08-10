# 1. Prepare data
if (!exists("myData")) {
  
  # 1.1. Read raw data
  myData <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", as.is=TRUE)
  
  # 1.2. Convert first variable to date
  myData$Date <- as.Date(myData$Date, format = "%d/%m/%Y")
  
  # 1.3. Get data only for the dates between 2007-02-01 and 2007-02-02
  myData <- subset(myData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
  
  # 1.4. Convert second column to Date/Time
  dateTimeString <- paste( myData$Date, myData$Time )
  myData$Time <- strptime( dateTimeString, format = "%Y-%m-%d %H:%M:%S")
}

# 2. Build a graph
# 2.1. Change the time locale temporarily
myTimeLocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# 2.2. Draw the graph
with(myData, plot(Time, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

# 2.3. Change the locale back
Sys.setlocale("LC_TIME", myTimeLocale)

# 3. Save it to PNG
dev.copy(png, file="plot2.png", height = 480, width = 480)
dev.off()