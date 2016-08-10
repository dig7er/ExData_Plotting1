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
with(myData, plot(Time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")) # add sub metering 1
with(myData, lines(Time, Sub_metering_2, col="red"))  # add sub metering 2
with(myData, lines(Time, Sub_metering_3, col="blue")) # add sub metering 3

# 2.3. Add legend
legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"),
    lty = 1,
    y.intersp = 1.25,
    text.width = 0.25*48*60*60  # the length is provided in X axis units (seconds).
                                # the length is set to 25% of the whole range 48 h = 12 h
)

# 2.4. Change the locale back
Sys.setlocale("LC_TIME", myTimeLocale)

# 3. Save it to a PNG
dev.copy(png, file="plot3.png", height = 480, width = 480)
dev.off()