library(data.table)
data <- fread("../household_power_consumption.txt", na.strings = "?",colClasses='character')
x1 <- subset(data, data[[1]]=="1/2/2007")
x2 <- subset(data, data[[1]]=="2/2/2007")
y <- rbind(x1,x2)

# Time
date <- as.POSIXct(y$Date, format="%d/%m/%y")
date <- as.numeric(date)
time <- as.POSIXct(y$Time, format="%H:%M:%S")
time <-as.numeric(time)
t <- date + time
t <- t-min(t)
t <- t/max(t)            # normalization

# Global_active_power
gap <- y[["Global_active_power"]]
gap <- as.numeric(gap)

# Voltage
vol <-y[["Voltage"]]
vol <-as.numeric(vol)

# Energy Sub Metering 1 
esm1 <- y[["Sub_metering_1"]]
esm1 <- as.numeric(esm1)

# Energy Sub Metering 2
esm2 <- y[["Sub_metering_2"]]
esm2 <- as.numeric(esm2)

# Energy Sub Metering 3
esm3 <- y[["Sub_metering_3"]]
esm3 <- as.numeric(esm3)

# Global reactive power
grp <- y[["Global_reactive_power"]]
grp <- as.numeric(grp)


# Plot
par(mfrow=c(2,2), mar=c(4,4,2,1))

# subplot(1,1)
plot(t, gap, type="l", axes=FALSE, xlab="", ylab="Global Active Power")
axis(side=2)
axis(side=1, at=c(0,0.5,1), labels=c("Thu","Fri","Sat"))
box()

# subplot(1,2)
plot(t, vol, type="l", axes=FALSE, xlab="datetime",ylab="Global_reactive_power")
axis(side=2)
axis(side=1, at=c(0,0.5,1), labels=c("Thu","Fri","Sat"))
box()

# subplot(2,1)
plot(c(0,1),c(0,40),type="n",axes=FALSE,xlab="",ylab="Energy sub metering")
lines(t,esm1,type="l",col="black")
lines(t,esm2,type="l",col="red")
lines(t,esm3,type="l",col="blue")
axis(side=2)
axis(side=1, at=c(0,0.5,1), labels=c("Thu","Fri","Sat"))
box()
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,cex=0.75,y.intersp=0.5)

# subplot(2,2)
plot(t, grp, type="l", axes=FALSE, xlab="datetime",ylab="Global_reactive_power")
axis(side=2)
axis(side=1, at=c(0,0.5,1), labels=c("Thu","Fri","Sat"))
box()

# Save as PNG file
dev.copy(png, file = "plot4.png")
dev.off()