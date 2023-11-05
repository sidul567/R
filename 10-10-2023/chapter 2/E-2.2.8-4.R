library(shiny)

ui <- fluidPage(
  selectInput("select", "", choices = list("color" = list("red", "yellow", "blue", "green", "orange"), "code" = list(120, 121, 122, 123, 124)))
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)