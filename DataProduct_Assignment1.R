#setwd("/home/jared/Documents/Coursera/Developing Data Products/Assignment1")
setwd("E:\\_Personal\\Developing Data Products\\Assignment1")
rds.filename <- 'Property_Assessment_Data.rds'
censusfilename <- "census.rds"

Property_Assessment_Data <- readRDS(rds.filename)
dfCensus <- readRDS(censusfilename)


#filter out condos
library(dplyr)

df <- Property_Assessment_Data %>%
  filter(Assessment_Class == "Residential"  ) %>% 
  select(Neighbourhood, Assessed_Value_Dollar, Assessed_Value_Amount, Latitude, Longitude) %>%
  filter(Assessed_Value_Amount > 0) %>%
  group_by(Neighbourhood) %>%
  slice(which.max(Assessed_Value_Amount))


#Join by Neighbourhood
joined <- inner_join(df, dfCensus, by="Neighbourhood")

#icon_location <- "/home/jared/Documents/Coursera/Developing Data Products/Assignment1/house-icon3.png"
icon_location <- "house-icon3.png"

library(leaflet)

propertyIcon <- makeIcon(
  iconUrl = icon_location,
  iconWidth = 20,
  iconHeight = 20
)

#Note I kept getting the error when I just did lat=Latitude and lng=Longitude
#Error in inherits(f, "formula") : object 'Longitude' not found
#The columns in your data frame are expressed as formulas, and formulas start with a tilde ~

my_map1 <- leaflet(df) %>%
  addTiles() %>%
  addMarkers(lng=~Longitude, lat=~Latitude, popup=~Neighbourhood, label=~Assessed_Value_Dollar,
             icon=propertyIcon, clusterOptions = markerClusterOptions() )
my_map1
  
my_map2 <- leaflet(df) %>%
  addTiles() %>%
  addCircleMarkers(lng=~Longitude, lat=~Latitude, popup=~Neighbourhood, label=~Assessed_Value_Dollar,
             clusterOptions = markerClusterOptions(), weight=1, radius=~Assessed_Value_Amount/100000 )
my_map2

my_map3 <- leaflet(joined) %>%
  addTiles() %>%
  addCircleMarkers(lng=~Longitude, lat=~Latitude, popup=~Neighbourhood, label=~Assessed_Value_Dollar,
                   clusterOptions = markerClusterOptions(), weight=1, radius=~Total_Pop/100 )
my_map3

#Size of bubble is proportional to Per 1000 population within the neighbourhood
my_map4 <- leaflet(joined) %>%
  addTiles() %>%
  addCircleMarkers(lng=~Longitude, lat=~Latitude, popup=~Neighbourhood, label=~Assessed_Value_Dollar,
                   weight=1, radius=~Total_Pop/1000 )
my_map4
