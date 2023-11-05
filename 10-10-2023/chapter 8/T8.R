library(shiny)
library(waiter)

ui <- fluidPage(
  useWaitress(),
  numericInput("n","Steps", 10),
  actionButton("btn", "RUN"),
  textOutput("result"),
)

server <- function(input, output, session) {
  data <- eventReactive(input$btn, {
    waitress <- Waitress$new(max = input$n, theme = "overlay-percent")
    on.exit(waitress$close())
    
    for(i in seq_len(input$n)){
      Sys.sleep(0.5)
      waitress$inc(1)
    }
    
    runif(1)
  })
  
  output$result <- renderText(round(data(), 2))
}

shinyApp(ui, server)