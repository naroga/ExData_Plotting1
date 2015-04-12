f <- gzfile("household_power_consumption.txt.gz","rt");

nolines <- 100
greped<-c()
repeat {
  lines=readLines(f,n=nolines)       
  idx <- grep("^[12]/2/2007", lines) 
  greped<-c(greped, lines[idx])      

  if(nolines!=length(lines)) {
    break 
  }
}
close(f)

tc<-textConnection(greped,"rt") 
df<-read.table(tc,sep=";", col.names = colnames(read.table(
  "household_power_consumption.txt.gz",
  nrow = 1, header = TRUE, sep=";")), na.strings = "?")

df$Date <- as.Date(df$Date , "%d/%m/%Y")
df$Time <- paste(df$Date, df$Time, sep=" ")
df$Time <- strptime(df$Time, "%Y-%m-%d %H:%M:%S")
png("plot2.png", width = 480, height = 480)
plot(df$Time, df$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off
