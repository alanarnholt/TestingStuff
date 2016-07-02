# From ISCAM III
library(XML)
library(RCurl)
myurl <- "https://en.wikipedia.org/wiki/List_of_motor_vehicle_deaths_in_U.S._by_year"
mypage <- getURL(myurl, .opts=list(ssl.verifypeer = FALSE))
table1 <- readHTMLTable(mypage, which=1, 
                       colClasses = c("integer", "character", "numeric", 
                                      "numeric", "character", "numeric", "character"))
head(table1)
names(table1) = c("year", "death", "vmt", "fatalitiesVMT", "population", "fatalities", "percentchange")
str(table1)
table1$population = as.numeric(gsub(",", "", table1$population))
table1$death = as.numeric(gsub(",", "", table1$death))
table1$percentchange = as.numeric(gsub("%", "", table1$percentchange))

library(ggplot2)
ggplot(data = table1, aes(x = year, y = death)) + geom_point() + geom_line(linetype = "dashed") + theme_bw()
str(table1)
mean(table1$death, na.rm = TRUE)
