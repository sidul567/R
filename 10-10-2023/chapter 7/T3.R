library(shiny)
library(ggplot2)

ui <- fluidPage(
  plotOutput("plot", brush = "clickPlot"),
  tableOutput("table"),
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) +
      geom_point()
  }, res = 96)
  
  output$table <- renderTable({
    return (brushedPoints(mtcars, input$clickPlot))
  })
}

shinyApp(ui, server)