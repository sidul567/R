library(RSelenium)
library(netstat)
library(tidyverse)
library(crayon)

#connect chrome driver
client_server <- rsDriver(
  browser = "chrome",
  chromever = "117.0.5938.63",
  verbose = FALSE,
  port = free_port(),
)

# connect remote driver to client
driver <- client_server$client

driver$maxWindowSize()
driver$navigate("https://google.com")

searchText <- "4 star hotel in gulshan"

driver$findElement("css selector", "textarea[type = 'search']")$sendKeysToElement(list(searchText, key = 'enter'))

driver$findElement("xpath", "//*[@id='Rzn5id']/div/a[2]")$clickElement()
Sys.sleep(0.5)

# Select number of guest
driver$findElement("css selector", "div.R2w7Jd")$clickElement()
driver$findElement("css selector", "div.au30Ld")$clickElement()
Sys.sleep(3)

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

isFindHotel <- TRUE

for(i in 0:6){
  try({
    elements <- driver$findElements("css selector", ".K1smNd > c-wiz[jsrenderer='hAbFdb'] span.Q01V4b span[jsaction='mouseenter:JttVIc;mouseleave:VqIRre;']")
    
    if(length(elements) == 0){
      isFindHotel <- FALSE
      cat(red("No hotel found!"))
      break
    }
    
    singleDayPrices <- lapply(elements, function(element){
      return(as.character(element$getElementText()))
    })
    
    prices[[as.character(today()+i)]] <- singleDayPrices[nzchar(singleDayPrices)]
    
    # Select next day
    driver$findElement("xpath", "//*[@id='yDmH0d']/c-wiz[2]/div/c-wiz/div[1]/div[1]/div[1]/c-wiz/div/div/div[1]/div/div[1]/div[2]/div/div/div[2]/div[1]/div/div[3]/button/span[1]")$clickElement()
    Sys.sleep(5)
  })
}

print(red(isFindHotel))

if(isFindHotel){
  prices_df <- as.data.frame(do.call(cbind, prices))
  prices_df <- cbind(city="gulshan", type="4 star", prices_df)
  prices_df <- apply(prices_df, c(1,2), as.character)
  write.csv(prices_df, file = paste0(searchText,".csv"), row.names = FALSE)
  View(prices_df)
}

# prices <- unlist(prices[nzchar(prices)])
# prices