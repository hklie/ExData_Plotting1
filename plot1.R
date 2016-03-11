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
# Now generate histogram for Global Active Power (column = 3)
#
hist(as.numeric(D$V3), xlab = 'Global Active Power (kilowatts)',main =
       'Global Active Power', col = 'red')
#
# Copy plot to a PNG file
#
dev.copy(png, file = "plot1.png")
dev.off()  