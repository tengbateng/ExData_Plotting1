
################################################################################################
##   SCRIPT OVERVIEW
##   What it does: Plots a line graph showing values of Global Active Power vs Date and time from
##              hpc data frame
##
##   Source Data: household_power_consumption.txt
##                originally from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##                only data for 1/2/2007 - 2/2/2007 are read into the hpc dataframe
##
##   Output: a line graph named plot2.png saved in the working directory
##
##   Prerequisites:
##           1. the data file household_power_consumption.txt must be in the working directory
##           2. the R package sqldf and lubridate must be installed 
##
################################################################################################

plot2 <- function(){
    
    library(sqldf)
    library(lubridate)
    
    
    ## Read data needed from file
    hpc <- read.csv.sql("household_power_consumption.txt", 
                        sep = ";", 
                        header = TRUE, 
                        sql ="select * from file where Date ='1/2/2007' 
                        or Date = '2/2/2007'")
    
    
    ## Create an extra field that combines both date and time
    hpc$DateTime <- dmy_hms(paste(hpc$Date, hpc$Time))
    
    ## Plot the line graph
    png("plot2.png", width = 480, height = 480)
    plot(hpc$DateTime, hpc$Global_active_power, 
          type = "n", xlab = "", 
          ylab = "Global Active Power (kilowatts)")
    lines(hpc$DateTime,hpc$Global_active_power )
    dev.off()
    
    
}