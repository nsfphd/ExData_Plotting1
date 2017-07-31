#Import data, subset to extract only days of interest, and create 
#Date/Time column for plotting

data_file<-read.csv("household_power_consumption.txt", sep=";", na.strings = c("?"))
data_file[['Date']]<-strptime(data_file[['Date']], format='%d/%m/%Y')
sub_file<-subset(data_file, Date>"2007-01-31"& Date<"2007-02-03")
sub_file$DtTime<-strptime(paste(sub_file$Date, sub_file$Time), format='%F %T')

#load graphics device, partition screen, plot four plots, two of which are
#repeats (with minor change to delete box on legend), two of which are basic

quartz()
par(mfrow=c(2,2))
with(sub_file, plot(as.POSIXct(DtTime), Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=NA))
with(sub_file, plot(as.POSIXct(DtTime),Voltage, type="l", xlab='datetime'))
with(sub_file, plot(as.POSIXct(DtTime),Sub_metering_1, type="l", ylab="Energy sub metering", xlab=NA))
lines(as.POSIXct(sub_file$DtTime),sub_file$Sub_metering_2, col="red")
lines(as.POSIXct(sub_file$DtTime),sub_file$Sub_metering_3, col="blue")
legend('topright', names(sub_file)[7:9], lty=1, col=c('black', 'red','blue'), bty='n', cex=0.75)
with(sub_file, plot(as.POSIXct(DtTime),Global_reactive_power, type="l", xlab='datetime'))

dev.copy(png, 'plot4.png', width=480, height=480)
