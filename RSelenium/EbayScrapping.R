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
driver$navigate("https://ebay.com")

driver$findElement("xpath", "//*[@id='mainContent']/div[1]/ul/li[3]/a")$clickElement()

driver$findElement("id", "gh-ac")$sendKeysToElement(list("Playstation 5", key = 'enter'))

country <- driver$findElement("xpath", "//*[@id='x-refine__group_1__2']/ul/li[1]/div/a/div/span/input")

country$clickElement()

prices <- lapply(driver$findElements("css selector", ".srp-results .s-item__price"), function(element){
  as.character(element$getElementText())
})

prices <- unlist(prices)
prices
