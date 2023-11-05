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

# navigate to a new page
url <- "https://quotes.toscrape.com"
driver$navigate(url)

# Get current URL
print(driver$getCurrentUrl())

# Maximize window
driver$maxWindowSize()

# Find element
loginLink <- driver$findElement(using = "xpath",  value = "/html/body/div/div[1]/div[2]/p/a")

print(loginLink$getElementTagName())
print(loginLink$getElementText())
print(loginLink$getElementAttribute("href"))
  
# Click on the element
loginLink$clickElement()
Sys.sleep(1)

# Go back 
# driver$goBack()
# Sys.sleep(2.5)
# cat("go back!")

# # Go forward
# driver$goForward()
# Sys.sleep(2.5)
# cat("go forward!")

# Find all elements
allLinksInHomepage <- driver$findElements("tag name", "a")

print(paste0("Number of links in home page: ", length(allLinksInHomepage)))

# Print links in data frame

# df <- data.frame()
# 
# for (i in 1:length(allLinksInHomepage)) {
#   textFromLinks <- as.character(allLinksInHomepage[[i]]$getElementText())
#   urlFromLinks <- as.character(allLinksInHomepage[[i]]$getElementAttribute("href"))
# 
#   tempDf <- data.frame(index = nrow(df)+1,
#                        text = textFromLinks,
#                        url = urlFromLinks
#                        )
#   df <- rbind(df, tempDf)
# 
#   cat(paste0(textFromLinks, ": ",blue(urlFromLinks), "\n"))
# }
# 
# View(df)

# Pagination

# i <- 0
# 
# quotes <- data.frame()
# 
# getElementText <- function(element){
#   as.character(element$getElementText())
# }
# 
# getURL <- function(element){
#   as.character(element$getElementAttribute("href"))
# }
# 
# # Get all quotes
# repeat{
#   cat("page: ",red(i+1), "\n")
# 
#   allQuotes <- driver$findElements(using = "css selector", value = "div.quote")
# 
#   # for(j in 1:length(allQuotes)){
#   #   cat(magenta(quotes[[j]]$getElementText()), "\n\n")
#   # }
# 
#   quoteText <- sapply(driver$findElements(using = "css selector", value = "div.quote span.text"), getElementText)
# 
#   cat("\n\n\n")
#   authorName <- sapply(driver$findElements(using = "css selector", value = "div.quote small.author"), getElementText)
# 
#   authorURL <- sapply(driver$findElements(using = "link text", value = "(about)"), getURL)
# 
#   tags <- sapply(driver$findElements(using = "css selector", value = "div.tags"), getElementText)
# 
#   quotesLength <- length(allQuotes)
# 
#   tempQuotes <- data.frame(index = (i * quotesLength + 1) : (i * quotesLength + quotesLength),
#                            quote = quoteText,
#                            author = authorName,
#                            authorInfo = authorURL,
#                            tags = tags
#                            )
#   quotes <- rbind(quotes, tempQuotes)
#   flush.console()
#   i <- i+1
# 
#   nextLink <- driver$findElements(using = "css selector", value = "li.next a")
# 
#   if(length(nextLink) == 0){
#     break
#   }
# 
#   nextLink[[1]]$clickElement()
#   Sys.sleep(0.1)
# }
# 
# write.csv(quotes, file = "quotes.csv", quote = FALSE, row.names = FALSE, fileEncoding = "UTF-8")
# view(quotes)

# Get all authors Information
# uniqueAuthorLinks <- unique(quotes$authorInfo)
# cat("Total Unique Author: ", length(uniqueAuthorLinks))

# authorsInfo <- data.frame()
#   
# for(link in uniqueAuthorLinks){
#   driver$navigate(link)
#   Sys.sleep(0.1)
#   
#   name <- driver$findElement("css selector", "h3.author-title")$getElementText()
#   bornDate <- driver$findElement("css selector", "span.author-born-date")$getElementText()
#   bornLocation <- driver$findElement("css selector", "span.author-born-location")$getElementText()
#   description <- driver$findElement("css selector", "div.author-description")$getElementText()
#   
#   tempAuthorsInfo <- data.frame(index = nrow(authorsInfo)+1, 
#                                 name = as.character(name),
#                                 bornDate = as.character(bornDate),
#                                 bornLocation = as.character(bornLocation),
#                                 description = as.character(description)
#                           )
#   
#   cat("\n", nrow(authorsInfo)+1, " of ", length(uniqueAuthorLinks), "\n")
#   flush.console()
#   
#   authorsInfo <- rbind(authorsInfo, tempAuthorsInfo)
# }
# 
# view(authorsInfo)

# Form handling
usernameInput <- driver$findElement("id", "username")
passwordInput <- driver$findElement("id", "password")
submitBtn <- driver$findElement("xpath", "/html/body/div/form/input[2]")

usernameInput$clearElement()
usernameInput$sendKeysToElement(list("Moon"))

passwordInput$clearElement()
passwordInput$sendKeysToElement(list("123", key='enter'))
Sys.sleep(2)

# submitBtn$submitElement()

Sys.sleep(2)
driver$navigate("https://httpbin.org/forms/post")

driver$findElement("xpath", "/html/body/form/p[1]/label/input")$sendKeysToElement(list("Moon"))

driver$findElement("xpath", "/html/body/form/p[2]/label/input")$sendKeysToElement(list("01712345678"))

driver$findElement("xpath", "/html/body/form/p[3]/label/input")$sendKeysToElement(list("moon@gmail.com"))

radioButtons <- driver$findElements("css selector", "input[type='radio']")
radioButtons[[3]]$clickElement()

checkButtons <- driver$findElements("css selector", "input[type='checkbox']")
lapply(checkButtons[c(1,2,4)], function(element){ element$clickElement() })

deliveryTime <- driver$findElement("css selector", "input[type='time']")$sendKeysToElement(list("19:45"))

instruction <- driver$findElement("name", "comments")$sendKeysToElement(list("Give me it as soon as possible!"))

Sys.sleep(3)

driver$findElement("xpath", "/html/body/form/p[6]/button")$clickElement()

Sys.sleep(3)

driver$quit()
driver$closeServer()

rm(driver, client_server)
