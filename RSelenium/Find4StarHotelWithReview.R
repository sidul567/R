library(RSelenium)
library(netstat)
library(tidyverse)
library(crayon)

#connect chrome driver
client_server <- rsDriver(
  browser = "chrome",
  chromever = "119.0.5735.90",
  verbose = FALSE,
  port = free_port(),
)

# connect remote driver to client
driver <- client_server$client

driver$maxWindowSize()
driver$navigate("https://google.com")

searchText <- "4 star hotel in gulshan"
Sys.sleep(3)

driver$findElement("css selector", "textarea[type='search']")$sendKeysToElement(list(searchText, key = 'enter'))

driver$findElement("xpath", "//*[@id='Rzn5id']/div/a[2]")$clickElement()
Sys.sleep(0.5)

# Select number of guest
tryCatch({
  driver$findElement("css selector", "div.R2w7Jd")$clickElement()
  driver$findElement("css selector", "div.au30Ld")$clickElement()
  Sys.sleep(3)
},
error = function(e){
  cat(red("No hotel found!"))
  stop()
}
)

roomPrices <- list()

isFindHotel <- TRUE

roomType <- c("Single", "Double", "Triple", "Family")

#filterTab
driver$findElement("xpath", "/html/body/c-wiz[2]/div/c-wiz/div[1]/div[1]/div[1]/c-wiz/div/div/div[1]/div/div[2]/div[1]/div/div/div[1]/div/button")$clickElement()
Sys.sleep(1)

#mostReviewButton
driver$findElement("xpath", "/html/body/c-wiz[2]/div/c-wiz/div[1]/div[1]/div[1]/c-wiz/div/div/div[1]/div/div[2]/div[1]/div/div[2]/div[3]/div/div[2]/div/div[1]/div/div/section[1]/div/div/div/div[4]/div/input")$clickElement()

#increasePrice
driver$findElement("xpath", "/html/body/c-wiz[2]/div/c-wiz/div[1]/div[1]/div[1]/c-wiz/div/div/div[1]/div/div[2]/div[1]/div/div[2]/div[3]/div/div[2]/div/div[1]/div/div/section[2]/div/div/div[2]/div/div[2]/input")$sendKeysToElement(list(key='right_arrow'))
                                                            
#closeFilterTab
driver$findElement("xpath", "/html/body/c-wiz[2]/div/c-wiz/div[1]/div[1]/div[1]/c-wiz/div/div/div[1]/div/div[2]/div[1]/div/div[2]/div[3]/div/div[1]/div[2]/span/button")$clickElement()
Sys.sleep(3)

for(room in roomType){
  # Click on date picker
  driver$findElement("xpath", "//*[@id='yDmH0d']/c-wiz[2]/div/c-wiz/div[1]/div[1]/div[1]/c-wiz/div/div/div[1]/div/div[1]/div[2]/div/div/div[2]/div[1]/div/input")$clickElement()
  Sys.sleep(0.5)
  
  # Select check in date
  driver$findElement("css selector", paste0("div[data-iso='", today(), "']"))$clickElement()
  Sys.sleep(0.5)
  
  # Select check out date
  driver$findElement("css selector", paste0("div[data-iso='", today()+1, "']"))$clickElement()
  Sys.sleep(2)
  
  # Submit date picker
  driver$findElement("xpath", "/html/body/c-wiz[2]/div/c-wiz/div[1]/div[1]/div[1]/c-wiz/div/div/div[1]/div/div[1]/div[2]/div/div[2]/div/div[2]/div[4]/div/button[2]")$clickElement()
  
  Sys.sleep(5)
  
  prices <- list()
  
  for(i in 0:1){
    try({
      # get all prices in a single page
      elementPrices <- driver$findElements("css selector", ".K1smNd > c-wiz[jsrenderer='hAbFdb'] span.Q01V4b span[jsaction='mouseenter:JttVIc;mouseleave:VqIRre;']")
      
      if(length(elementPrices) == 0){
        isFindHotel <- FALSE
        break
      }
      
      singleDayPrices <- lapply(elementPrices, function(element){
        return(as.character(element$getElementText()))
      })
      
      prices[[as.character(today()+i)]] <- singleDayPrices
      
      # Select next day
      driver$findElement("xpath", "//*[@id='yDmH0d']/c-wiz[2]/div/c-wiz/div[1]/div[1]/div[1]/c-wiz/div/div/div[1]/div/div[1]/div[2]/div/div/div[2]/div[1]/div/div[3]/button/span[1]")$clickElement()
      Sys.sleep(5)
    })
  }
  
  if(!isFindHotel){
    break
  }
  
  # get all reviews in a single page
  elementReviews <- driver$findElements("css selector", ".K1smNd > c-wiz[jsrenderer='hAbFdb'] .KFi5wf")
  
  singleDayReviews <- lapply(elementReviews, function(element){
    return(as.character(element$getElementText()))
  })
  
  # get hotel names from a single page
  elementHotelNames <- driver$findElements("css selector", ".K1smNd > c-wiz[jsrenderer='hAbFdb'] div.QT7m7 h2[jsaction = 'YcW9n:dDUAne;']")
  
  singleDayHotelName <- lapply(elementHotelNames, function(element){
    return(as.character(element$getElementText()))
  })
  
  roomPrices[[room]] <- prices
  roomPrices[[room]][["Reviews"]] <- singleDayReviews
  roomPrices[[room]][["HotelName"]] <- singleDayHotelName
  
  
  # Select guest
  driver$findElement("css selector", ".UkpQCd")$clickElement()
  Sys.sleep(2)
  
  # increase guest number
  driver$findElement("xpath", "/html/body/c-wiz[2]/div/c-wiz/div[1]/div[1]/div[1]/c-wiz/div/div/div[1]/div/div[1]/div[3]/div/div/div/div[2]/div[2]/div/div[1]/div[1]/div[2]/div/span[3]/button")$clickElement()
  
  # Submit guest number
  driver$findElement("xpath", "/html/body/c-wiz[2]/div/c-wiz/div[1]/div[1]/div[1]/c-wiz/div/div/div[1]/div/div[1]/div[3]/div/div/div/div[2]/div[2]/div/div[2]/div[2]/button")$clickElement()
  
  Sys.sleep(5)
}

if(length(roomPrices$Single) > 0 || length(roomPrices$Double) > 0 || length(roomPrices$Triple) > 0 || length(roomPrices$Family) > 0){
  prices_df <- data.frame()
  for(room in roomType){
    if(length(roomPrices[[room]]) > 0){
      tempPriceDf <- as.data.frame(do.call(cbind, roomPrices[[room]]))
      tempPriceDf <- cbind(City="gulshan", Type="4 star", RoomType = room, tempPriceDf)
      
      prices_df <- rbind(prices_df, tempPriceDf)
    }
  }
  prices_df <- apply(prices_df, c(1,2), as.character)
  prices_df <- subset(prices_df, !apply(prices_df, 1, function(row) any(row == "")))
  write.csv(prices_df, file = paste0(searchText,".csv"), row.names = FALSE)
  View(prices_df)
}else{
  cat(red("No hotel found!"))
}

# prices <- unlist(prices[nzchar(prices)])
# prices







# elementPrices <- driver$findElements("css selector", ".K1smNd > c-wiz[jsrenderer='hAbFdb'] div.PwV1Ac")
# 
# p <- lapply(elementPrices, function(element){
#   return(as.character(element$getElementText()))
# })
