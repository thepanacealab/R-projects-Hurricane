library(RPostgreSQL)
library(sqldf)
library(dyplr)
library(sp)
library(rgdal)
drv <- dbDriver("PostgreSQL")
conn <-dbConnect(drv,host='localhost',port='5432',dbname='psh_tweets',user='#####',password='######')

#Getting the tweets one month before hurricane Irma started
uniqueUserList2 <- dbGetQuery(conn,
"SELECT tweetuser,date(tweetcreated),TRIM (
 LEADING '['
 FROM
 split_part(tweetgeocoord, ',', 1)
 ) as lat, TRIM (
 TRAILING ']'
 FROM
 split_part(tweetgeocoord, ',', 2)
 ) as long,tweetpname
FROM tweets_info 
WHERE tweetgeotype='Point' and tweetcreated BETWEEN '2017-07-31' AND '2017-08-30'
ORDER BY tweetuser;")


#county from lat long


#SpatialPolygonDataFrame
counties <- readOGR("C:/Users/Bhaskar/Desktop/PCS/LAB/StudentList/shapefile/new", "cb_2017_us_county_500k")
for(i in 1:nrow(uniqueUserList2)) {
Lat <- as.double(uniqueUserList2[i,"lat"]) 
Lon <- as.double(uniqueUserList2[i,"long"])
#make a data frame
coords <- as.data.frame(cbind(Lon,Lat))
#and into Spatial
points <- SpatialPoints(coords)
#assume same proj as shapefile!
proj4string(points) <- proj4string(counties)
#get county polygon point is in
uniqueUserList2[i, "county"] <- as.character(over(points, counties)$NAME)
}


#Remove emptys
uniqueUserList2CleanNotNull <- subset(uniqueUserList2, !is.na(county))

#Finding county frequency
uniqueUserList2CleanNotNullCountyFrequency<-sqldf("SELECT tweetuser, county,COUNT(*) AS frequency
FROM 'uniqueUserList2CleanNotNull'
GROUP BY tweetuser,county;",drv="SQLite")

#Selecting the top frequency
uniqueUserList2CleanNotNullCountyFrequencyTop <- uniqueUserList2CleanNotNullCountyFrequency %>% group_by(tweetuser) %>% top_n(1, frequency)

#Filter by EVAC county
uniqueUserList2CleanNotNullCountyFrequencyTopFiltered<-merge(uniqueUserList2CleanNotNullCountyFrequencyTop,tweetcountyirmaAll,by="county")

#User ID
uniqueUserList2CleanNotNullCountyFrequencyTopFilteredID <-data.frame("tweetuser" = uniqueUserList2CleanNotNullCountyFrequencyTopFiltered$tweetuser)


#Getting tweets data during irma hurricane time 
testirmaHurricaneTime<-dbGetQuery(conn,
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
WHERE tweetgeotype='Point' and tweetcreated BETWEEN '2017-08-30' AND '2017-09-14'
GROUP BY  tweetuser,lat,long,date(tweetcreated),tweetpname
ORDER BY date(tweetcreated);"
)

#filter tweets by user id
testirmaHurricaneTimeUser<-merge(testirmaHurricaneTime,uniqueUserList2CleanNotNullCountyFrequencyTopFilteredID,by="tweetuser")

#Getting tweets data after irma hurricane
testirmaAfterHurricaneTime<-dbGetQuery(conn,
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
WHERE tweetgeotype='Point' and tweetcreated BETWEEN '2017-09-14' AND '2017-10-14'
GROUP BY  tweetuser,lat,long,date(tweetcreated),tweetpname
ORDER BY date(tweetcreated);"
)

#filter tweets by user id
testirmaAfterHurricaneTimeUser<-merge(testirmaAfterHurricaneTime,uniqueUserList2CleanNotNullCountyFrequencyTopFilteredID,by="tweetuser")


