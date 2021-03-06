## Read in data and generate a plot
## Note: the data used is electric power consumption data from UC Irvine
## For the purposes of this function, the data must have been saved from
## the source (given below) and extracted from the zip file, and the file
## must not have been renamed.
## Here is the source of the data:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
plot1 <- function(workdir = "~/devel/Coursera/datascience/4-expdata-cp1/ExData_Plotting1/"
                  , datadir = "~/Google Drive/Dev/Coursera/4-ExpData/") {
    ## Make sure we have access to fread
    require("data.table")
    
    ## Read data, extracting only the header row and dates of interest
    ## First, read in the data
    suppressWarnings(data <- fread(
        paste0(datadir, "household_power_consumption.txt")
        , sep=";",
        , na.strings="?"
        , select=c("Date", "Global_active_power")
        , data.table=FALSE))

    ## Next, reduce and transform the data to only that which we need for
    ## the plot
    ## Get just the two days we want
    data <- data[data$Date %in% c('1/2/2007', '2/2/2007'),]

    ## Convert the column(s) to appropriate data type(s)
    data$Global_active_power <- as.numeric(data$Global_active_power)
    
    ## Open the device to which the plot(s) will be saved
    png(filename = paste0(workdir, "plot1.png"))

    ## Generate the plot(s)
    hist(data$Global_active_power
         , main = "Global Active Power"
         , xlab = "Global Active Power (kilowatts)"
         , col = "red"
         )

    ## Close the device
    dev.off()
}
