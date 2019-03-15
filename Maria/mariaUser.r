library(RPostgreSQL)
library(sqldf)
library(dyplr)
library(sp)
library(rgdal)
drv <- dbDriver("PostgreSQL")
conn <-dbConnect(drv,host='localhost',port='5432',dbname='psh_tweets',user='#####',password='######')

#Getting the tweets one month before hurricane maria started
testmaria1beforeNewChangeString1<-dbGetQuery(conn,
"SELECT CAST(tweetuser AS varchar(1000)),date(tweetcreated),TRIM (
 LEADING '['
 FROM
 split_part(tweetgeocoord, ',', 1)
 ) as lat, TRIM (
 TRAILING ']'
 FROM
 split_part(tweetgeocoord, ',', 2)
 ) as long,tweetpname,COUNT(tweettext)
FROM tweets_info 
WHERE tweetgeotype='Point' and tweetcreated BETWEEN '2017-08-15' AND '2017-09-16'
GROUP BY  tweetuser,date(tweetcreated),lat,long,tweetpname
ORDER BY date(tweetcreated);
")


#county from lat long

#SpatialPolygonDataFrame
counties <- readOGR("/home/bhaskar/Routput/shapefile", "cb_2017_us_county_500k")
for(i in 1:nrow(testmaria1beforeNewChangeString1)) {
Lat <- as.double(testmaria1beforeNewChangeString1[i,"lat"]) 
Lon <- as.double(testmaria1beforeNewChangeString1[i,"long"])
#make a data frame
coords <- as.data.frame(cbind(Lon,Lat))
#and into Spatial
points <- SpatialPoints(coords)
#assume same proj as shapefile!
proj4string(points) <- proj4string(counties)
#get county polygon point is in
testmaria1beforeNewChangeString1[i, "county"] <- as.character(over(points, counties)$NAME)
}


#Remove emptys
testmaria1beforeNewChangeString1CleanNotNull <- subset(testmaria1beforeNewChangeString1, !is.na(county))


#County Frequency
testmaria1beforeNewChangeString1CleanNotNullFrequency<-sqldf("SELECT tweetuser, county,COUNT(*) AS frequency
FROM 'testmaria1beforeNewChangeString1CleanNotNull'
GROUP BY tweetuser,county;",drv="SQLite")


#Select Top
testmaria1beforeNewChangeString1CleanNotNullFrequencyTop <- testmaria1beforeNewChangeString1CleanNotNullFrequency %>% group_by(tweetuser) %>% top_n(1, frequency)

#Filtered by EVAC county
testmaria1beforeNewChangeString1CleanNotNullFrequencyTopFiltered<-merge(testmaria1beforeNewChangeString1CleanNotNullFrequencyTop,tweetcountyMariaEVAC,by="county")

#User ID
testmaria1beforeNewChangeString1CleanNotNullFrequencyTopFilteredID <-data.frame("tweetuser" = testmaria1beforeNewChangeString1CleanNotNullFrequencyTopFiltered$tweetuser)

#Tweets During hurricane maria
mariaHurricaneTime<-dbGetQuery(conn,
"SELECT tweetuser,date(tweetcreated),TRIM (
 LEADING '['
 FROM
 split_part(tweetgeocoord, ',', 1)
 ) as lat, TRIM (
 TRAILING ']'
 FROM
 split_part(tweetgeocoord, ',', 2)
 ) as long,tweetpname,COUNT(tweettext)
FROM tweets_info 
WHERE tweetgeotype='Point' and tweetcreated BETWEEN '2017-09-16' AND '2017-10-03'
GROUP BY  tweetuser,lat,long,date(tweetcreated),tweetpname
ORDER BY date(tweetcreated);"
)


#filter tweets by user id
mariaHurricaneTimeUser<-merge(mariaHurricaneTime,testmaria1beforeNewChangeString1CleanNotNullFrequencyTopFilteredID,by="tweetuser")




#Tweets after hurricane maria
mariaAfterHurricaneTime<-dbGetQuery(conn,
"SELECT tweetuser,date(tweetcreated),TRIM (
 LEADING '['
 FROM
 split_part(tweetgeocoord, ',', 1)
 ) as lat, TRIM (
 TRAILING ']'
 FROM
 split_part(tweetgeocoord, ',', 2)
 ) as long,tweetpname,COUNT(tweettext)
FROM tweets_info 
WHERE tweetgeotype='Point' and tweetcreated BETWEEN '2017-10-03' AND '2017-11-02'
GROUP BY  tweetuser,lat,long,date(tweetcreated),tweetpname
ORDER BY date(tweetcreated);"
)

#Filtered by id
mariaAfterHurricaneTimeUser<-merge(mariaAfterHurricaneTime,testmaria1beforeNewChangeString1CleanNotNullFrequencyTopFilteredID,by="tweetuser")


