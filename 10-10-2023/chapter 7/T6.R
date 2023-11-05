library(shiny)

ui <- fluidPage(
  sliderInput("height", "height", 100, 500, 250),
  sliderInput("width", "width", 100, 500, 250),
  plotOutput("plot")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(x = rnorm(30), y = rnorm(30))
  }, width = function() input$width, height = function() input$height, res = 96)
}

shinyApp(ui, server)