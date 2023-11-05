library(shiny)

ui <- fluidPage(
  sliderInput("date", "When should we deliver?", min = as.Date("2020-09-16"), max = as.Date("2020-09-2023"), value = as.Date("2020-09-17"))
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)