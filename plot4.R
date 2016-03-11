#
# Read portion of the file corresponding to the rows 1/1/2007 and 2/1/2007
#
filen <- 'household_power_consumption.txt'
start_line <- grep('1/2/2007', readLines(filen))
nlines <- 60 * 48    # 60 minutes x 48 hours
#
# Suppress warnings and read quietly
#
options(warn = -1)
D <-
  read.table(
    filen, sep = ';', na.strings = '?', skip = start_line, nrows = nlines
  )
options(warn = 0)
#
# Convert to Date/time class and get global active power, global reactive power, Energy sub-metering and voltage in numeric format
#
t <- paste(D$V1,D$V2)
tim <- strptime(t,'%d/%m/%Y %H:%M:%S')
ES1 <- as.numeric(D$V7)
ES2 <- as.numeric(D$V8)
ES3 <- as.numeric(D$V9)
mm <- max(c(ES1,ES2,ES3))
GAP <- as.numeric(D$V3)
GRP <- as.numeric(D$V4)
VOLT <- as.numeric(D$V5)
#
# Now generate plots for each quantity vs weekdays in a 2x2 matrix arrangement
#
par(mfcol=c(2,2))

plot(tim, GAP, xlab = '', ylab = 'Global Active Power',type =
       'l')

plot(
  tim, ES1, xlab = '', ylab = 'Energy sub metering', type = 'l', col = 'black', ylim =
    c(0.,mm)
)
par(new = T)
plot(
  tim, ES2, xlab = '', ylab = 'Energy sub metering', type = 'l', col = 'red', ylim =
    c(0.,mm)
)
par(new = T)
plot(
  tim, ES3, xlab = '', ylab = 'Energy sub metering', type = 'l', col = 'blue', ylim =
    c(0.,mm)
)
legend(
  'topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty = c(1,1,1), col =
    c('black','red','blue')
)
par(new = F)

plot(tim, VOLT, xlab = '', ylab = 'Voltage',type =
       'l')

plot(tim, GRP, xlab = '', ylab = 'Global Reactive Power',type =
       'l')

#
# Copy plot to a PNG file
#
dev.copy(png, file = "plot4.png")
dev.off()  