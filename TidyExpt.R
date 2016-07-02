### Build data frame

stuff <- data.frame(name = c("Appalachian", "Georgia", "USMA"), 
                    cost = c(10, 12, 14), students = c(100, 200, 300),
                    treatmenta = c(NA, 4, 6), treatmentb = c(18, 1, 7),
                    treatmentc = c(5, NA, 3),
                    stringsAsFactors = FALSE)
stuff
str(stuff)
###
library(dplyr)
library(tidyr)
stuff2 <- tbl_df(stuff) %>% 
  gather(treatment, numbers, treatmenta:treatmentc) %>% 
  arrange(name, numbers)
stuff2
######
library(ggplot2)
ggplot(data = stuff2, aes(x = cost, y = numbers)) + geom_point()
tapply(stuff2$students, stuff2$name, mean)
library(PDS)
dim(ipeds_pds)
names(ipeds_pds)[1:50]
####
ipeds <- tbl_df(ipeds_pds) %>% 
  gather(cipcode, major, c(cipcode_flmbm1, cipcode_flmbm2, cipcode_csbm1, cipcode_csbm2)) %>% 
  gather(ctotalt, GrandTotal, c(ctotalt_flmbm1, ctotalt_flmbm2, ctotalt_csbm1, ctotalt_csbm2)) %>% 
  gather(ctotalw, TotalWomen, c(ctotalw_flmbm1, ctotalw_flmbm2, ctotalw_csbm1, ctotalw_csbm2)) %>% 
  gather(ctotalm, TotalMen, c(ctotalm_flmbm1, ctotalm_flmbm2, ctotalm_csbm1, ctotalm_csbm2))
dim(ipeds)
hist(ipeds$GrandTotal)
hist(ipeds$TotalWomen)
table(ipeds$major)
ipeds$major <- factor(ipeds$major, labels = c("computer science", "film"))
table(ipeds$major)
dim(ipeds)

with(data = ipeds, boxplot(GrandTotal ~ major))
library(ggplot2)
ggplot(data = ipeds, aes(x = major, y = GrandTotal)) + geom_boxplot()
# This one makes no sense
ggplot(data = ipeds, aes(x = cipcode, y = GrandTotal)) + geom_boxplot()
#
ggplot(data = ipeds, aes(x = cipcode, y = GrandTotal)) + geom_boxplot() + facet_grid(.~major)
ggplot(data = ipeds, aes(x = major, y = TotalWomen)) + geom_boxplot()
tapply(ipeds$TotalWomen, ipeds$major, mean, na.rm = TRUE)
tapply(ipeds$GrandTotal, ipeds$major, mean, na.rm = TRUE)

xtabs(TotalWomen ~ major, data = ipeds)

table(unique(ipeds$cipcode))

length((ipeds$GrandTotal))
length(unique(ipeds$unitid))
length(unique(ipeds_pds$unitid))

levels(ipeds$major)
str(ipeds$major)
# str(ipeds$ctotalt)
dim(ipeds)


ipeds[1:5, c("unitid", "TotalWomen", "GrandTotal", "major")]
NIP <- ipeds[ , c("unitid", "TotalWomen", "TotalMen", "GrandTotal", "major")]
NIP <- na.omit(NIP)
NIP
length(unique(NIP$unitid))
DIFF <- (NIP$GrandTotal - NIP$TotalWomen)
DIFF
########################
junk <- ipeds_pds %>% 
  filter(unitid == 110705)
