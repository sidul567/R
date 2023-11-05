library(RSelenium)
library(netstat)
library(tidyverse)
library(xml2)
library(rvest)
library(data.table)

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
driver$navigate("https://salaries.texastribune.org/search/?q=%22Department+of+Public+Safety%22")
dataTable <- driver$findElement("id", "pagination-table")

allData <- list()


repeat{
  dataTableHTML <- dataTable$getPageSource()
  page <- read_html(dataTableHTML %>% unlist())
  df <- html_table(page)[[2]]
  allData <- rbindlist(list(allData, df))

  tryCatch(
    {
      nextButton <- driver$findElement("xpath", "//*[@id='pagination-table-wrapper']/ul/li[2]/a")$clickElement()
    },
    error = function(e){
      print("Script complete!")
      break
    }
  )
}








