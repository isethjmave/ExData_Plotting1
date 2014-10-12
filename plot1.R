#read original data
df <- read.table("household_power_consumption.txt",header=T, sep=";")

#get the data for the corresponding that we want to use
dfSS1 <- subset(df,df$Date == as.character("1/2/2007"))
dfSS2 <- subset(df,df$Date == as.character("2/2/2007"))

#combine the data
dfSS <- rbind(dfSS1,dfSS2)

#write the extracted data to a csv file
write.csv(dfSS, file = "data.csv", row.names = FALSE)

#read in the extracted data
dfn <- read.csv("data.csv")

#create histogram and save it to png file
png("plot1.png", height=480, width=480)
hist(dfn$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()
