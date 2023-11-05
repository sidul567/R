library(shiny)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("result"),
)

server <- function(input, output, session) {
  output$result <- renderText(paste0("Hello, ", input$name, "!"))
}

shinyApp(ui, server)