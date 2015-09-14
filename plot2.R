library(data.table)
data <- fread("../household_power_consumption.txt", na.strings = "?",colClasses='character')
x1 <- subset(data, data[[1]]=="1/2/2007")
x2 <- subset(data, data[[1]]=="2/2/2007")
y <- rbind(x1,x2)

# Global_active_power
gap <- y[["Global_active_power"]]
gap2 <- as.numeric(gap)

# Time
date <- as.POSIXct(y$Date, format="%d/%m/%y")
date <- as.numeric(date)
time <- as.POSIXct(y$Time, format="%H:%M:%S")
time <-as.numeric(time)
t <- date + time
t <- t-min(t)
t <- t/max(t)            # normalization

# Plot
plot(t, gap2, type="l", axes=FALSE, xlab="", ylab="Global Active Power (kilowatts)")
axis(side=2)
axis(side=1, at=c(0,0.5,1), labels=c("Thu","Fri","Sat"))
box()

# Save as PNG file
dev.copy(png, file = "plot2.png")
dev.off()