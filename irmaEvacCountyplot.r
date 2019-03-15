library(tigris)
library(leaflet)
library(raster)
library(leaflet.extras)
library(tidyverse)
library(mapview)


voluntarycountyfl <- read.csv("/home/bhaskar/Routput/csv/tweetcountyfloridaVOL.csv", stringsAsFactors=F)
mendatorycountyfl <- read.csv("/home/bhaskar/Routput/csv/tweetcountyfloridaEVAC.csv", stringsAsFactors=F)
mendatorycountyga <- read.csv("/home/bhaskar/Routput/csv/tweetcountygeorgiaEVAC.csv", stringsAsFactors=F)


mendatorytrackfl <- tracts(state = 'FL', mendatorycountyfl)
voluntarytrackfl <- tracts(state = 'FL', voluntarycountyfl)

mendatorytrackga <- tracts(state = 'GA', mendatorycountyga)

popup_sb  <-paste0("EVAC Mendatory Florida County")
popup_sb2 <-paste0("EVAC Voluntary Florida County")
popup_sb3 <-paste0("EVAC Mendatory Georgia County")


m1 <- leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(-82.922454, 31.600153, zoom = 4) %>% 
 

  addPolygons(data =mendatorytrackfl, 
              stroke = TRUE,
              color = "red",
              opacity = 5,
              fillOpacity = 0.7, 
              weight = 0.2, 
              smoothFactor = 0.2) %>%

addPolygons(data = voluntarytrackfl, 
              stroke = TRUE,
              color = "yellow",
              opacity = 5,                
              fillOpacity = 0.7, 
              weight = 0.2, 
              smoothFactor = 0.2, 
              popup = ~popup_sb2) %>% 

addPolygons(data = mendatorytrackga , 
              stroke = TRUE,
              color = "red",
              opacity = 5,                
              fillOpacity = 0.7, 
              weight = 0.2, 
              smoothFactor = 0.2, 
              popup = ~popup_sb3) %>% 

addLegend("bottomright", colors= c("red", "yellow"), labels=c("Mendatory", "Voluntary"), title="Hurricane Irma EVAC")

m1

#mapshot(m1, file = "/home/bhaskar/Routput/irma.png")