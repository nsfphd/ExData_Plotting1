#Import data, subset to extract only days of interest, and create 
#Date/Time column for plotting

data_file<-read.csv("household_power_consumption.txt", sep=";", na.strings = c("?"))
data_file[['Date']]<-strptime(data_file[['Date']], format='%d/%m/%Y')
sub_file<-subset(data_file, Date>"2007-01-31"& Date<"2007-02-03")
sub_file$DtTime<-strptime(paste(sub_file$Date, sub_file$Time), format='%F %T')

#launch graphics device, plot data without mods since base is correct

quartz()
with(sub_file, plot(as.POSIXct(DtTime), Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=NA))
dev.copy(png, 'plot2.png', width=480, height=480)
