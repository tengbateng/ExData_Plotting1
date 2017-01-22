
################################################################################################
##   SCRIPT OVERVIEW
##   What it does: Plots four line graphs:
##                  1. Global active power vs datetime
##                  2. Voltage vs datetime
##                  3. Energy sub metering vs datetime
##                  4. Global reactive power vs datetime
##
##   Source Data: household_power_consumption.txt
##                originally from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##                only data for 1/2/2007 - 2/2/2007 are read into the hpc dataframe
##
##   Output: a line graph named plot4.png saved in the working directory
##
##   Prerequisites:
##           1. the data file household_power_consumption.txt must be in the working directory
##           2. the R package sqldf and lubridate must be installed 
##
################################################################################################

plot4 <- function(){
    
    library(sqldf)
    library(lubridate)
    
    hpc <- read.csv.sql("household_power_consumption.txt", 
                        sep = ";", 
                        header = TRUE, 
                        sql ="select * from file where Date ='1/2/2007' or Date = '2/2/2007'")
    
    ## Create an extra field that combines both date and time
    hpc$DateTime <- dmy_hms(paste(hpc$Date, hpc$Time))
    
    
    png("plot4.png", width = 480, height = 480)
    ## Setup the chart layout
    par(mfrow=c(2,2))
    
    ## Plot GAP vs Datetime line graph
    plot(hpc$DateTime, hpc$Global_active_power, xlab="", ylab="Global Active Power", type = "n")
    lines(hpc$DateTime, hpc$Global_active_power)
    
    ## Plot the Voltage vs Datetime line graph
    plot(hpc$DateTime, hpc$Voltage, xlab="datetime", ylab="Voltage", type = "n")
    lines(hpc$DateTime,hpc$Voltage)
    
    ## Plot the sub metering vs datetime line graph
    plot(hpc$DateTime, hpc$Sub_metering_1, type="n", 
         xlab="", ylab="Energy sub metering")
    lines(hpc$DateTime, hpc$Sub_metering_1)
    lines(hpc$DateTime, hpc$Sub_metering_2, col="red")
    lines(hpc$DateTime, hpc$Sub_metering_3, col="blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col=c("black", "red", "blue" ), 
           lwd = c(2.5, 2.5, 2.5))
    
    ## Plot the global reactive power vs datetime line graph
    plot(hpc$DateTime, hpc$Global_reactive_power, type="n", 
               xlab="datetime", ylab="Global_reactive_power")
    lines(hpc$DateTime, hpc$Global_reactive_power)
    
    dev.off()
    
    
}