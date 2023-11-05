library(shiny)

ui <- fluidPage(
  textInput("text", "", placeholder = "Your name")
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)