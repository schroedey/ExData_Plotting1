## Read in data and generate a plot
## Note: the data used is electric power consumption data from UC Irvine
## For the purposes of this function, the data must have been saved from
## the source (given below) and extracted from the zip file, and the file
## must not have been renamed.
## Here is the source of the data:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
plot4 <- function(workdir = "~/devel/Coursera/datascience/4-expdata-cp1/ExData_Plotting1/"
                  , datadir = "~/Google Drive/Dev/Coursera/4-ExpData/") {
    ## Make sure we have access to fread
    require("data.table")
    
    ## Read data, extracting only the header row and dates of interest
    ## First, read in the data
    suppressWarnings(data <- fread(
        paste0(datadir, "household_power_consumption.txt")
        , sep=";",
        , na.strings="?"
        , select=c("Date", "Time"
                   , "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"
                   , "Global_active_power", "Global_reactive_power", "Voltage")
        , data.table=FALSE))
    
    ## Next, reduce and transform the data to only that which we need for
    ## the plot
    ## Get just the two days we want
    data <- data[data$Date %in% c('1/2/2007', '2/2/2007'),]
    
    ## Convert the column(s) to appropriate data type(s)
    ## NB: Technically, the Time column will now have both the date and time,
    ## and the Date column is being left in the data set, but plotting data vals
    ## against Time (which is now date and time) produces the desired graph
    data$Time <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
    data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
    data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
    data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
    data$Global_active_power <- as.numeric(data$Global_active_power)
    data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
    data$Voltage <- as.numeric(data$Voltage)
    
    ## Open the device to which the plot(s) will be saved
    png(filename = paste0(workdir, "plot4.png"))
    
    # Set the plot layout and plot generation order
    par(mfcol = c(2, 2))
    
    ## Generate the plot(s)
    ## plot 1 (upper left)
    plot(data$Time
         , data$Global_active_power
         , type = "l"
         , xlab = ""
         , ylab = "Global Active Power"
    )
    
    ## plot 2 (lower left)
    plot(data$Time
         , data$Sub_metering_1
         , type = "l"
         , xlab = ""
         , ylab = "Energy sub metering"
    )
    points(data$Time, data$Sub_metering_2, type = "l", col = "red")
    points(data$Time, data$Sub_metering_3, type = "l", col = "blue")
    legend("topright"
           , lwd = 1
           , col = c("black", "red", "blue")
           , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

    ## plot 3 (upper right)
    plot(data$Time
         , data$Voltage
         , type = "l"
         , xlab = "datetime"
         , ylab = "Voltage"
    )
    
    ## plot 4 (upper right)
    plot(data$Time
         , data$Global_reactive_power
         , type = "l"
         , xlab = "datetime"
         , ylab = "Global_reactive_power"
    )

    ## Close the device
    dev.off()
}
