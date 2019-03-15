library(tigris)
library(leaflet)
library(raster)
library(leaflet.extras)
library(tidyverse)
library(mapview)

tweets <- read.csv("/home/bhaskar/Routput/maria/mariaHurricaneTimeUser.csv", stringsAsFactors=F)

setwd("/home/bhaskar/Routput/maria/duringMaria")

datesArray <-c("2017-09-16","2017-09-17","2017-09-18","2017-09-19","2017-09-20","2017-09-21","2017-09-22","2017-09-23","2017-09-24","2017-09-25","2017-09-26","2017-09-27","2017-09-28","2017-09-29","2017-09-30","2017-10-01","2017-10-02")

for (i in 1:length(datesArray)) {
  datedata<-tweets[tweets$date== datesArray[i],]
  #states_merged_sb1 <- geo_join(me, datedata, "NAME", "county")
  # Creating a color palette based on the number range in the total column
  #pal <- colorNumeric("Reds", domain=states_merged_sb1$freq)  <--- Scales within sample 
  pal <- colorNumeric("Reds", domain=min(tweets$count):max(tweets$count))  #Scales within dataset
  # Getting rid of rows with NA values
  #states_merged_sb1 <- subset(states_merged_sb1, !is.na(count))
  # Setting up the pop up text
  #popup_sb <- paste0("Tweet Location",as.character(states_merged_sb1$NAME) , "\n Total: ", as.character(states_merged_sb1$count))
  # Mapping it with the new tiles CartoDB.Positron
  m <- leaflet(datedata) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-85.254375, 36.614730, zoom = 4) %>% 
	addHeatmap(lng = ~long, lat = ~lat, intensity = ~count, blur = 10, max = 0.05, radius = 5) %>%
    addLegend(pal = pal, values = min(tweets$count):max(tweets$count), position = "topleft", title = paste("During Hurricane: ",datesArray[i],sep=''), opacity = 1) 
    mapshot(m, file = paste("tweetsFrequency_",gsub('/','-',datesArray[i]),".png",sep=''))
}
