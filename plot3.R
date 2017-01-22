
################################################################################################
##   SCRIPT OVERVIEW
##   What it does: Plots a line graph showing 3 sub metering variables vs Date and time from
##              hpc data frame
##
##   Source Data: household_power_consumption.txt
##                originally from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##                only data for 1/2/2007 - 2/2/2007 are read into the hpc dataframe
##
##   Output: a line graph named plot3.png saved in the working directory
##
##   Prerequisites:
##           1. the data file household_power_consumption.txt must be in the working directory
##           2. the R package sqldf and lubridate must be installed 
##
################################################################################################

plot3 <- function(){
    
    library(sqldf)
    library(lubridate)
    
    hpc <- read.csv.sql("household_power_consumption.txt", 
                        sep = ";", 
                        header = TRUE, 
                        sql ="select * from file where Date ='1/2/2007' or Date = '2/2/2007'")
    
    ## Create an extra field that combines both date and time
    hpc$DateTime <- dmy_hms(paste(hpc$Date, hpc$Time))
    
    ## Plot the line graph
    png("plot3.png", width = 480, height = 480)
    plot(hpc$DateTime, hpc$Sub_metering_1, type="n", 
         xlab="", ylab="Energy sub metering")
    
    # Add the lines
    lines(hpc$DateTime, hpc$Sub_metering_1)
    lines(hpc$DateTime, hpc$Sub_metering_2, col="red")
    lines(hpc$DateTime, hpc$Sub_metering_3, col="blue")
    
    #Add Legend
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col=c("black", "red", "blue" ), 
           lwd = c(2.5, 2.5, 2.5))
    
    dev.off()
    
    
}