

################################################################################################
##   SCRIPT OVERVIEW
##   What it does: Plots a histogram of the frequency of values of Global Active Power from
##              hpc data frame
##
##   Source Data: household_power_consumption.txt
##                originally from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##                only data for 1/2/2007 - 2/2/2007 are read into the hpc dataframe
##
##   Output: a histogram named plot1.png saved in the working directory
##
##   Prerequisites:
##           1. the data file household_power_consumption.txt must be in the working directory
##           2. the R package sqldf must be installed 
##
################################################################################################

plot1 <- function(){
    
    library(sqldf)
    
    hpc <- read.csv.sql("household_power_consumption.txt", 
                        sep = ";", 
                        header = TRUE, 
                        sql ="select * from file where Date ='1/2/2007' or Date = '2/2/2007'")
    

    ## Plot the first histogram
    png("plot1.png", width = 480, height = 480)
    hist(hpc$Global_active_power, 
         col= "#FF2500", 
         xlab = "Global Active Power (kilowatts)", 
         main = "Global Active Power")
    dev.off()
    
    
}