library(shiny)
library(googlesheets4)
library(httr)    
httr::set_config(httr::config(http_version = 2))
options(shiny.host = "0.0.0.0")
options(shiny.port = 5000)

# options(gargle_oauth_cache = ".secrets")
# gs4_auth()
# list.files(".secrets/")
# gs4_deauth()
gs4_auth(cache = ".secrets", email = "saleforecast.online@gmail.com")
datf <- read_sheet("https://docs.google.com/spreadsheets/d/19ZsUaiKat_MC0zHJv1cKY0G_y1E91WEna7AFIalddCo/edit#gid=0", col_types = "c")
ui <- fluidPage(
  tableOutput("table"),
)

server <- function(input, output, session) {
  output$table <- renderTable(datf)
}

shinyApp(ui, server)