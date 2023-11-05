library(shiny)

ui <- fluidPage(
  numericInput("n", "n", value = 10),
  actionButton("simulate", "Simulate"),
  plotOutput("hist")
)

server <- function(input, output, session) {
  
  values <- reactiveValues(x = rnorm(10))
  
  observeEvent(input$simulate, {
    values$x <- rnorm(input$n)
  })
  
  output$hist <- renderPlot({
    plot(values$x)
  })
  
}

shinyApp(ui, server)