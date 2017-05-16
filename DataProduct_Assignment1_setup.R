#DataProduct_Assignment1 R code
setwd("/home/jared/Documents/Coursera/Developing Data Products/Assignment1")
setwd("/home/jared/Downloads/Developing Data Products/Assignment1")
setwd("E:\\_Personal\\Developing Data Products\\Assignment1")

#install.packages("leaflet", "plotly")

library(readr)
Property_Assessment_Data <- read_csv("~/Documents/Coursera/Developing Data Products/Assignment1/Property_Assessment_Data.csv")
hdr <- c("Account_Number", "Suite", "House_Number", "Street_Name", "Assessed_Value_Dollar", "Assessment_Class", 
         "Neighbourhood", "Garage", "Latitude", "Longitude" )
names(Property_Assessment_Data) <- hdr

#convert $values to numeric
Property_Assessment_Data$Assessed_Value_Amount <- as.numeric(sub('\\$','', Property_Assessment_Data$Assessed_Value_Dollar )) 

rds.filename <- 'Property_Assessment_Data.rds'

saveRDS(Property_Assessment_Data, rds.filename)




#2016 Census data, population by neighbourhood: https://data.edmonton.ca/Census/2016-Census-Population-by-Age-Range-Neighbourhood-/phd4-y42v

#Import census
Census <- read_csv("~/Documents/Coursera/Developing Data Products/Assignment1/2016_Census_-_Population_by_Age_Range__Neighbourhood_Ward_.csv")
Census <- read_csv("2016_Census_-_Population_by_Age_Range__Neighbourhood_Ward_.csv")
dfCensus <- Census %>% mutate(totalPop = rowSums(.[4:22]))
#dfCensus$totalPop[dfCensus$totalPop == 0] <- NA
#avgTotalPop <- round(mean(dfCensus$totalPop, na.rm = TRUE))
#dfCensus$totalPop[is.na(dfCensus$totalPop)] <- avgTotalPop


census_varnames <- c("Ward", "Neighbourhood_Number", "Neighbourhood", "0 - 4", "5 - 9", 
                     "10 - 14", "15 - 19", "20 - 24",
                     "25 - 29", "30 - 34", "35 - 39", "40 - 44", 
                     "45 - 49", "50 - 54", "55 - 59", "60 - 64", 
                     "65 - 69", "70 - 74", "75 - 79", "80 - 84", 
                     "85+", "No Response", "Total_Pop")

names(dfCensus) <- census_varnames


censusfilename <- "census.rds"

saveRDS(dfCensus, censusfilename)