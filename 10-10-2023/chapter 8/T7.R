library(shiny)

ui <- fluidPage(
  numericInput("n","Steps", 10),
  actionButton("btn", "RUN"),
  textOutput("result"),
)

server <- function(input, output, session) {
  data <- eventReactive(input$btn, {
    withProgress(message = "Computing random number", {
      for(i in seq(input$n)){
        Sys.sleep(0.5)
        incProgress(1/input$n)
      }
      runif(1)
    })
  })
  
  output$result <- renderText(round(data(), 2))
}

shinyApp(ui, server)