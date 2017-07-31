#Import data, subset to extract only days of interest, and create 
#Date/Time column for plotting

data_file<-read.csv("household_power_consumption.txt", sep=";", na.strings = c("?"))
data_file[['Date']]<-strptime(data_file[['Date']], format='%d/%m/%Y')
sub_file<-subset(data_file, Date>"2007-01-31"& Date<"2007-02-03")
sub_file$DtTime<-strptime(paste(sub_file$Date, sub_file$Time), format='%F %T')

#launch graphics device, plot first data series, add second two series, add
#legend with labels

quartz()
with(sub_file, plot(as.POSIXct(DtTime),Sub_metering_1, type="l", ylab="Energy sub metering", xlab=NA))
lines(as.POSIXct(sub_file$DtTime),sub_file$Sub_metering_2, col="red")
lines(as.POSIXct(sub_file$DtTime),sub_file$Sub_metering_3, col="blue")
legend('topright', names(sub_file)[7:9], lty=1, col=c('black', 'red','blue'), bty=1, cex=0.75)
dev.copy(png, 'plot3.png', width=480, height=480)