tweetcountyfloridaEVAC<-data.frame("county" = c("Jackson","Jefferson","Wakulla","Franklin","Taylor","Suwannee","Lafayette","Dixie","Gilchrist","Baker",
"Levy","Marion","Citrus","Sumter","Hernando","Pasco","Hillsborough","Pinellas","Clay","Duval","Nassau","St. Johns","Flagler",
"Volusia","Seminole","Orange","Polk","Manatee","Hardee","Sarasota","Desoto","Charlotte","Glades","Lee","Collier","Monroe",
"Miami-Dade","Broward","Palm Beach","Martin","Brevard","St. Lucie","Indian River"))

tweetcountyfloridaVOL<-data.frame("county" = c("Walton","Bay","Gulf","Hamilton","Union","Putnam","Lake","Osceola","Highlands","Okeechobee","Hendry"))

tweetcountygeorgiaEVAC <-data.frame("county" = c("Appling","Atkinson","Bacon","Brantley","Bryan","Bulloch","Burke","Camden","Candler",
"Charlton","Chatham","Clinch","Coffee","Echols","Effingham","Effingham","Evans","Glynn","Jenkins",
"Jeff Davis","Liberty","Long","McIntosh","Pierce","Screven","Tattnall","Toombs","Treutlen","Wayne","Ware"))


tweetcountyirmaAll<-data.frame("county" = c("Jackson","Jefferson","Wakulla","Franklin","Taylor","Suwannee","Lafayette","Dixie","Gilchrist","Baker",
"Levy","Marion","Citrus","Sumter","Hernando","Pasco","Hillsborough","Pinellas","Clay","Duval","Nassau","St. Johns","Flagler",
"Volusia","Seminole","Orange","Polk","Manatee","Hardee","Sarasota","Desoto","Charlotte","Glades","Lee","Collier","Monroe",
"Miami-Dade","Broward","Palm Beach","Martin","Brevard","St. Lucie","Indian River","Walton","Bay","Gulf","Hamilton","Union","Putnam","Lake","Osceola","Highlands","Okeechobee","Hendry","Appling","Atkinson","Bacon","Brantley","Bryan","Bulloch","Burke","Camden","Candler",
"Charlton","Chatham","Clinch","Coffee","Echols","Effingham","Effingham","Evans","Glynn","Jenkins",
"Jeff Davis","Liberty","Long","McIntosh","Pierce","Screven","Tattnall","Toombs","Treutlen","Wayne","Ware"))


tweetcountyMariaEVAC<-data.frame("county"=c("Adjuntas","Aguada","Aguadilla","Aguas","Buenas","Aibonito","Anasco","Arecibo","Arroyo","Barceloneta","Barranquitas","Bayamon","Cabo Rojo","Caguas","Camuy", "Canovanas", "Carolina", "Catano", "Cayey", "Ceiba", "Ciales", "Cidra", "Coamo", "Comerio", "Corozal", "Culebra", "Dorado", "Fajardo", "Florida", "Guanica", "Guayama", "Guayanilla", "Guaynabo", "Gurabo", "Hatillo", "Hormigueros", "Humacao", "Isabela", "Jayuya", "Juana Diaz", "Juncos", "Lajas", "Lares", "Las Marias", "Las Piedras", "Loiza", "Luquillo", "Manati", "Maricao", "Maunabo", "Mayaguez", "Moca", "Morovis", "Naguabo", "Naranjito", "Orocovis", "Patillas", "Penuelas", "Ponce", "Quebradillas", "Rincon", "Rio Grande", "Sabana Grande", "Salinas", "San German", "San Juan", "San Lorenzo", "San Sebastian", "Santa Isabel", "Toa Alta", "Toa Baja", "Trujillo Alto", "Utuado", "Vega Alta", "Vega Baja", "Vieques", "Villalba", "Yabucoa", "Yauco"))


tweetcountyFIPSfloridaEVAC<-data.frame("FIPS" = c("12063","12065","12129","12037","12123","12121","12067","12029","12041","12003",
"12075","12083","12017","12119","12053","12101","12057","12103","12019","12031","12089","12109","12035",
"12127","12117","12095","12105","12081","12049","12115","12027","12015","12043","12071","12021","12087",
"12086","12011","12099","12085","12009","12111","12061"))

tweetcountyFIPSfloridaVOL<-data.frame("FIPS" = c("12131","12005","12045","12047","12125","13237","12069","12097","12055","12093","12051"))

tweetcountyFIPSgeorgiaEVAC <-data.frame("FIPS" = c("13001","13003","13005","13025","13029","13031","13033","13039","13043",
"13049","13051","13065","13069","13101","13103","13109","13127","13165",
"13161","13179","13183","13191","13229","13251","13267","13279","13283","13305","13299"))


tweetcountyFIPSirmaAll<-data.frame("FIPS" = c("12131","12005","12045","12047","12125","13237","12069","12097","12055","12093","12051","12063","12065","12129","12037","12123","12121","12067","12029","12041","12003",
"12075","12083","12017","12119","12053","12101","12057","12103","12019","12031","12089","12109","12035",
"12127","12117","12095","12105","12081","12049","12115","12027","12015","12043","12071","12021","12087",
"12086","12011","12099","12085","12009","12111","12061","13001","13003","13005","13025","13029","13031","13033","13039","13043",
"13049","13051","13065","13069","13101","13103","13109","13127","13165",
"13161","13179","13183","13191","13229","13251","13267","13279","13283","13305","13299"))





setwd("/home/bhaskar/Routput/csv")


write.csv(tweetcountyfloridaEVAC,file="tweetcountyfloridaEVAC.csv")
write.csv(tweetcountyfloridaVOL,file="tweetcountyfloridaVOL.csv")
write.csv(tweetcountygeorgiaEVAC,file="tweetcountygeorgiaEVAC.csv")
write.csv(tweetcountyirmaAll,file="tweetcountyirmaAll.csv")
write.csv(tweetcountyMariaEVAC,file="tweetcountyMariaEVAC.csv")
write.csv(tweetcountyFIPSfloridaVOL,file="tweetcountyFIPSfloridaVOL.csv")
write.csv(tweetcountyFIPSgeorgiaEVAC,file="tweetcountyFIPSgeorgiaEVAC.csv")
write.csv(tweetcountyFIPSgeorgiaEVAC,file="tweetcountyFIPSgeorgiaEVAC.csv")
write.csv(tweetcountyFIPSirmaAll,file="tweetcountyFIPSirmaAll.csv")









