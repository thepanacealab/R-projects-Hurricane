library(RCurl)
library(RJSONIO)
library(sqldf)
library(dyplr)


#function for API
latlong2fips2 <- function(latitude, longitude) {
  url <- "https://geo.fcc.gov/api/census/block/find?format=json&latitude=%f&longitude=%f"
  url <- sprintf(url, latitude, longitude)
  json <- RCurl::getURL(url)
  json <- RJSONIO::fromJSON(json)
  as.character(json$County['FIPS'])
}

#finding FIPS code
for(i in 1:nrow(testirmaHurricaneTimeUser)) {
testirmaHurricaneTimeUser[i, "FIPS"] <- latlong2fips2(latitude=as.double(testirmaHurricaneTimeUser[i,"lat"]), longitude=as.double(testirmaHurricaneTimeUser[i,"long"])) 
}

#finding FIPS code
for(i in 1:nrow(testirmaAfterHurricaneTimeUser)) {
testirmaAfterHurricaneTimeUser[i, "FIPS"] <- latlong2fips2(latitude=as.double(testirmaAfterHurricaneTimeUser[i,"lat"]), longitude=as.double(testirmaAfterHurricaneTimeUser[i,"long"])) 
}


#during hurricane irma

#Finding tweets frequency per day 
testirmaHurricaneTimeUserTweetsFrequency<-sqldf("SELECT date,SUM(count) AS TotalTweets
FROM 'testirmaHurricaneTimeUser'
GROUP BY date;",drv="SQLite")

#Finding the Evac zone inside tweets filtered by county FIPS code
testirmaHurricaneTimeUserInsideNewFIPS<-merge(testirmaHurricaneTimeUser,tweetcountyFIPSirmaAll,by="FIPS")

#Finding tweets frequency per day inside evac zone
testirmaHurricaneTimeUserInsideNewFIPSTweetsFrequency<-sqldf("SELECT date,SUM(count) AS TotalDuringHurricaneInsideTweets
FROM 'testirmaHurricaneTimeUserInsideNewFIPS'
GROUP BY date;",drv="SQLite")

#Finding the Evac zone outside tweets filtered by county FIPS code
testirmaHurricaneTimeUserOutsideEvacFIPS<-anti_join(testirmaHurricaneTimeUser,testirmaHurricaneTimeUserInsideNewFIPS, by="FIPS")

#Finding tweets frequency per day outside evac zone
testirmaHurricaneTimeUserOutsideEvacFIPSTweetsFrequency<-sqldf("SELECT date,SUM(count) AS TotalDuringHurricaneOutsideTweets
FROM 'testirmaHurricaneTimeUserOutsideEvacFIPS'
GROUP BY date;",drv="SQLite")


#Proportion of tweets during Irma
proportionOfTweetsDuringIrma <- data.frame("date" = testirmaHurricaneTimeUserTweetsFrequency$date,"TotalTweets"=testirmaHurricaneTimeUserTweetsFrequency$TotalTweets,"TotalDuringHurricaneInsideTweets"=testirmaHurricaneTimeUserInsideNewFIPSTweetsFrequency$TotalDuringHurricaneInsideTweets,"TotalDuringHurricaneOutsideTweets"=testirmaHurricaneTimeUserOutsideEvacFIPSTweetsFrequency$TotalDuringHurricaneOutsideTweets)

#Proportion of tweets during Irma
for(i in 1:nrow(proportionOfTweetsDuringIrma)) {
proportionOfTweetsDuringIrma[i, "insideTweetsProportion"] <- as.double(proportionOfTweetsDuringIrma[i,"TotalDuringHurricaneInsideTweets"])/as.double(proportionOfTweetsDuringIrma[i,"TotalTweets"])
proportionOfTweetsDuringIrma[i, "outSideTweetsProportion"] <- as.double(proportionOfTweetsDuringIrma[i,"TotalDuringHurricaneOutsideTweets"])/as.double(proportionOfTweetsDuringIrma[i,"TotalTweets"])
}



#after hurricane irma

#Finding tweets frequency per day 
testirmaAfterHurricaneTimeUserTweetsFrequency<-sqldf("SELECT date,SUM(count) AS TotalTweets
FROM 'testirmaAfterHurricaneTimeUser'
GROUP BY date;",drv="SQLite")


#Finding the Evac zone inside tweets filtered by county FIPS code
testirmaAfterHurricaneTimeUserInsideNewFIPS<-merge(testirmaAfterHurricaneTimeUser,tweetcountyFIPSirmaAll,by="FIPS")

#Finding tweets frequency per day inside evac zone
testirmaAfterHurricaneTimeUserInsideNewFIPSTweetsFrequency<-sqldf("SELECT date,SUM(count) AS TotalAfterHurricaneInsideTweets
FROM 'testirmaAfterHurricaneTimeUserInsideNewFIPS'
GROUP BY date;",drv="SQLite")

#Finding the Evac zone outside tweets filtered by county FIPS code
testirmaAfterHurricaneTimeUserOutsideEvacFIPS<-anti_join(testirmaAfterHurricaneTimeUser,testirmaAfterHurricaneTimeUserInsideNewFIPS, by="FIPS")

#Finding tweets frequency per day outside evac zone
testirmaAfterHurricaneTimeUserOutsideEvacFIPSTweetsFrequency<-sqldf("SELECT date,SUM(count) AS TotalAfterHurricaneOutsideTweets
FROM 'testirmaAfterHurricaneTimeUserOutsideEvacFIPS'
GROUP BY date;",drv="SQLite")

#Proportion of tweets after Irma
proportionOfTweetsAfterIrma <- data.frame("date" = testirmaAfterHurricaneTimeUserTweetsFrequency$date,"TotalTweets"=testirmaAfterHurricaneTimeUserTweetsFrequency$TotalTweets,"TotalAfterHurricaneInsideTweets"=testirmaAfterHurricaneTimeUserInsideNewFIPSTweetsFrequency$TotalAfterHurricaneInsideTweets,"TotalAfterHurricaneOutsideTweets"=testirmaAfterHurricaneTimeUserOutsideEvacFIPSTweetsFrequency$TotalAfterHurricaneOutsideTweets)


#Proportion of tweets after Irma
for(i in 1:nrow(proportionOfTweetsAfterIrma)) {
proportionOfTweetsAfterIrma[i, "insideTweetsProportion"] <- as.double(proportionOfTweetsAfterIrma[i,"TotalAfterHurricaneInsideTweets"])/as.double(proportionOfTweetsAfterIrma[i,"TotalTweets"])
proportionOfTweetsAfterIrma[i, "outSideTweetsProportion"] <- as.double(proportionOfTweetsAfterIrma[i,"TotalAfterHurricaneOutsideTweets"])/as.double(proportionOfTweetsAfterIrma[i,"TotalTweets"])

}