library(shiny)
library(shinycssloaders)
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),
  numericInput("n", "N", 0),
  actionButton("btn", "RUN"),
  withSpinner(plotOutput("plot"), type = 8, color = "red"),
)

server <- function(input, output, session) {
  data <- eventReactive(input$btn, {
    disable("btn")
    disable("n")
    Sys.sleep(1)
    enable("btn")
    enable("n")
    data.frame(x = rnorm(20), y = rnorm(20))
  })
  
  output$plot <- renderPlot(plot(data()), res = 96)
}

shinyApp(ui, server)