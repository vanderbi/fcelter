setwd("C://Users/kvand/OneDrive/Documents/github")

library(tidyverse)
getwd()


#install package tidyverse if not already installed
if(!require(tidyverse)){ install.packages("tidyverse") }  
library("tidyverse") 
infile1 <- trimws("https://pasta.lternet.edu/package/data/eml/knb-lter-fce/1069/11/6376dd06d6548631ec826f570cce8d42") 
infile1 <-sub("^https","http",infile1)
# This creates a tibble named: dt1 
dt1 <-read_delim(infile1  
                 ,delim=","   
                 ,skip=1,
                 col_names=c( 
                   "SITENAME",   
                   "Plot",   
                   "Date",   
                   "Salinity",   
                   "NandN",   
                   "NO2",   
                   "NH4",   
                   "SRP",   
                   "DOC",   
                   "NO3"   ), 
                 col_types=list(
                   col_character(),
                   col_number(),
                   col_date("%Y-%m-%d"),  
                   col_number() , 
                   col_number() , 
                   col_number() , 
                   col_number() , 
                   col_number() , 
                   col_number() , 
                   col_number() ), 
                 na=c( " ",".","NA")  )

library(readxl)

dtnew <- read_xlsx("./fcelter/LT_ND_Grahl_003/data/LT_ND_Grahl_003_formatted.xlsx", col_names = TRUE, col_types = NULL)
getwd()
dtnew

dtnew$Date <- as.Date(dtnew$Date,format = "%Y-%m-%d")
dtnew

combined <-bind_rows(dt1, dtnew)
combined

combined$Salinity <- sprintf("%.1f",combined$Salinity)
combined$NandN <- sprintf("%.2f", combined$NandN)
combined$NO2 <- sprintf("%.2f", combined$NO2)
combined$NH4 <- sprintf("%.2f", combined$NH4)
combined$SRP <- sprintf("%.2f", combined$SRP)
combined$DOC <- sprintf("%.3f", combined$DOC)
combined$SRP <- sprintf("%.2f", combined$NO3)

write.csv(combined, "./fcelter/LT_ND_Grahl_003/data/LT_ND_Grahl_003.txt", quote = FALSE, row.names = FALSE)


# Convert Missing Values to NA for individual vectors 
dt1$Salinity <- ifelse((trimws(as.character(dt1$Salinity))==trimws("-9999")),NA,dt1$Salinity)
dt1$NandN <- ifelse((trimws(as.character(dt1$NandN))==trimws("-9999.00")),NA,dt1$NandN)
dt1$NO2 <- ifelse((trimws(as.character(dt1$NO2))==trimws("-9999.00")),NA,dt1$NO2)
dt1$NH4 <- ifelse((trimws(as.character(dt1$NH4))==trimws("-9999.00")),NA,dt1$NH4)
dt1$SRP <- ifelse((trimws(as.character(dt1$SRP))==trimws("-9999.00")),NA,dt1$SRP)
dt1$DOC <- ifelse((trimws(as.character(dt1$DOC))==trimws("-9999.000")),NA,dt1$DOC)
dt1$NO3 <- ifelse((trimws(as.character(dt1$NO3))==trimws("-9999.00")),NA,dt1$NO3)


# Observed issues when reading the data. An empty list is good!
problems(dt1) 
# Here is the structure of the input data tibble: 
glimpse(dt1) 
# And some statistical summaries of the data 
summary(dt1) 
# Get more details on character variables