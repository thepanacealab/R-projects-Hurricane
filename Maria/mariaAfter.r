library(tigris)
library(leaflet)
library(raster)
library(leaflet.extras)
library(tidyverse)
library(mapview)

tweets <- read.csv("/home/bhaskar/Routput/maria/mariaAfterHurricaneTimeUser.csv", stringsAsFactors=F)

setwd("/home/bhaskar/Routput/maria/afterMaria")

datesArray <-c("2017-10-11","2017-10-12","2017-10-13","2017-10-14","2017-10-15")

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
    addLegend(pal = pal, values = min(tweets$count):max(tweets$count), position = "topleft", title = paste("After Hurricane: ",datesArray[i],sep=''), opacity = 1) 
    mapshot(m, file = paste("tweetsFrequency_",gsub('/','-',datesArray[i]),".png",sep=''))
}
