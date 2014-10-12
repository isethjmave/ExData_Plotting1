#check if dplyr package is installed - if not install dplyr package
if("dplyr" %in% rownames(installed.packages()) == FALSE) {
  install.packages("dplyr")
}

#load dplyr package
library(dplyr)

#read original data
df <- read.table("household_power_consumption.txt",header=T, sep=";")

#get the data for the corresponding that we want to use
dfSS1 <- subset(df,df$Date == as.character("1/2/2007"))
dfSS2 <- subset(df,df$Date == as.character("2/2/2007"))

#combine the data
dfSS <- rbind(dfSS1,dfSS2)

#write the extracted data to a csv file
write.csv(dfSS, file = "data.csv", row.names = FALSE)

#read in the new extracted data
dfn <- read.csv("data.csv")

#convert to data frame table
dfndf <- tbl_df(dfn)

#remove old data frame
rm(dfn)

#add datatime colume
dfndf <- mutate(dfndf,datetime = paste(Date,Time))

#create plot and save it to png file
png("plot3.png", height=480, width=480)
plot_colors <- c("black", "red", "blue")
plot(strptime(dfndf$datetime,"%d/%m/%Y %H:%M:%S"),dfndf$Sub_metering_1,type="n", xlab = "", ylab = "Energy Sub Metering")
lines(strptime(dfndf$datetime,"%d/%m/%Y %H:%M:%S"),dfndf$Sub_metering_1)
lines(strptime(dfndf$datetime,"%d/%m/%Y %H:%M:%S"),dfndf$Sub_metering_2,col="red")
lines(strptime(dfndf$datetime,"%d/%m/%Y %H:%M:%S"),dfndf$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=plot_colors,lwd=1, cex=1, xjust=1, yjust=1, y.intersp=1) 
dev.off()
