#Import data, subset to extract only days of interest, and create 
#Date/Time column for plotting

data_file<-read.csv("household_power_consumption.txt", sep=";", na.strings = c("?"))
data_file[['Date']]<-strptime(data_file[['Date']], format='%d/%m/%Y')
sub_file<-subset(data_file, Date>"2007-01-31"& Date<"2007-02-03")
sub_file$DtTime<-strptime(paste(sub_file$Date, sub_file$Time), format='%F %T')

#launch graphics device, plot data without labels (to match sample),
#then add axes to the specification

quartz()
hist(sub_file$Global_active_power, xlab="Global Active Power (kilowatts)", axes=FALSE, col="red", main="Global Active Power")
axis(side=1, at=c(0,2,4,6))
axis(side=2, at=c(0,200,400,600, 800, 1000, 1200))
dev.copy(png, 'plot1.png', width=480, height=480)