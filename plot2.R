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
# Convert to Date/time class and get GAP in numeric format
#
t <- paste(D$V1,D$V2)
tim <- strptime(t,'%d/%m/%Y %H:%M:%S')
GAP <- as.numeric(D$V3)
#
# Now generate plot for Global Active Power (column = 3) vs weekdays
#
plot(tim, GAP, xlab = '', ylab = 'Global Active Power (kilowatts)',type =
       'l')
#
# Copy plot to a PNG file
#
dev.copy(png, file = "plot2.png")
dev.off()  