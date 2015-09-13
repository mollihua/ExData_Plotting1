library(data.table)
data <- fread("../household_power_consumption.txt", na.strings = "?")
x1 <- subset(data, data[[1]]=="1/2/2007")
x2 <- subset(data, data[[1]]=="2/2/2007")
y <- rbind(x1,x2)

# Global_active_power
gap <- y[["Global_active_power"]]
gap2 <- as.numeric(gap)
hist(gap2,col='red',xlab="Global Active Power (kilowatts)", main="Global Active Power")

